# GCP values the GitLab pipeline needs, written as project-level CI/CD variables
locals {
  ci_variables = {
    GCP_PROJECT_ID            = var.project_id
    GCP_REGION                = var.region
    GCP_SERVICE_ACCOUNT       = google_service_account.gitlab_ci.email
    CLOUD_RUN_SERVICE_ACCOUNT = google_service_account.runtime.email
    GCP_WIF_PROVIDER          = google_iam_workload_identity_pool_provider.gitlab.name
    GCP_WIF_AUDIENCE          = "https://iam.googleapis.com/${google_iam_workload_identity_pool_provider.gitlab.name}"
    GCS_BUCKET                = google_storage_bucket.ml_bucket.name
    ARTIFACT_REPOSITORY       = google_artifact_registry_repository.spam_classifier.repository_id
    IMAGE_NAME                = var.service_name
    CLOUD_RUN_SERVICE         = google_cloud_run_v2_service.spam_classifier.name
    TF_PLAN_SERVICE_ACCOUNT  = google_service_account.terraform_plan.email #Terraform pipeline: service accounts the jobs log in as tf plan
    TF_APPLY_SERVICE_ACCOUNT = google_service_account.terraform_apply.email #Terraform pipeline: service accounts the jobs log in as tf apply
  }
}

resource "gitlab_project_variable" "ci" {
  for_each = local.ci_variables

  project   = var.gitlab_project_path
  key       = each.key
  value     = each.value
  environment_scope = var.gitlab_environment_scope # defines if variables are for prod/staging
  protected = false
  masked    = false
  raw       = true
}


