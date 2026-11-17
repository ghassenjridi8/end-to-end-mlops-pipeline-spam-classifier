# Service accounts used by the Terraform pipeline.
# terraform-plan:  read-only, usable by every pipeline (merge requests)
# terraform-apply: deploy tf configuration, usable only by pipelines on main


resource "google_service_account" "terraform_plan" {
  account_id   = "terraform-plan"
  display_name = "Terraform Plan (read-only)"

  depends_on = [google_project_service.required]
}

resource "google_service_account" "terraform_apply" {
  account_id   = "terraform-apply"
  display_name = "Terraform Apply"

  depends_on = [google_project_service.required]
}

#terraform-plan: read-only permissions

# read resources
resource "google_project_iam_member" "terraform_plan_viewer" {
  project = var.project_id
  role    = "roles/viewer"
  member  = google_service_account.terraform_plan.member
}

# read IAM policies
resource "google_project_iam_member" "terraform_plan_security_reviewer" {
  project = var.project_id
  role    = "roles/iam.securityReviewer"
  member  = google_service_account.terraform_plan.member
}

# read (not write) the Terraform state
resource "google_storage_bucket_iam_member" "terraform_plan_state" {
  bucket = var.tf_state_bucket
  role   = "roles/storage.objectViewer"
  member = google_service_account.terraform_plan.member
}



# terraform-apply: admin permissions for the resources Terraform manages

locals {
  terraform_apply_roles = [
    "roles/iam.serviceAccountAdmin",         # service accounts + their IAM
    "roles/iam.workloadIdentityPoolAdmin",   # WIF pool + provider
    "roles/resourcemanager.projectIamAdmin", # project-level IAM bindings
    "roles/serviceusage.serviceUsageAdmin",  # enable APIs
    "roles/storage.admin",                   # buckets + bucket IAM (the state bucket also)
    "roles/artifactregistry.admin",          # Docker repo + repo IAM
    "roles/run.admin",                       # Cloud Run service + its IAM
    "roles/secretmanager.admin",             # manage the GitLab token secret + read its value in the apply job
  ]
}

resource "google_project_iam_member" "terraform_apply" {
  for_each = toset(local.terraform_apply_roles)

  project = var.project_id
  role    = each.value
  member  = google_service_account.terraform_apply.member
}

# deploying Cloud Run service with the runtime SA as its identity 
resource "google_service_account_iam_member" "terraform_apply_acts_as_runtime" {
  service_account_id = google_service_account.runtime.name
  role               = "roles/iam.serviceAccountUser"
  member             = google_service_account.terraform_apply.member
}



# Who may use which SA (Workload Identity Federation) ? 

# terraform-plan: any pipeline of this GitLab project (all branches, including merge requests)
resource "google_service_account_iam_member" "terraform_plan_wif_user" {
  service_account_id = google_service_account.terraform_plan.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.gitlab.name}/attribute.project_path/${var.gitlab_project_path}"
}

# terraform-apply: only pipelines on the main branch
resource "google_service_account_iam_member" "terraform_apply_wif_user" {
  service_account_id = google_service_account.terraform_apply.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.gitlab.name}/attribute.ref_path/refs/heads/${var.gitlab_apply_branch}"
}


# GitLab write token for the apply job
# Terraform creates only the empty secret; the token value is added by hand, so it never ends up in the Terraform state.

resource "google_secret_manager_secret" "gitlab_token" {
  secret_id = "terraform-gitlab-token"

  replication {
    auto {}
  }

  depends_on = [google_project_service.required]
}



