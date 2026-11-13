locals {
  required_apis = [
    "cloudresourcemanager.googleapis.com", # Terraform: project-level IAM
    "iam.googleapis.com",                  # service accounts, Workload Identity pools
    "iamcredentials.googleapis.com",       # CI: impersonating gitlab-ci SA via WIF
    "sts.googleapis.com",                  # CI: exchanging the GitLab token for a Google token
    "storage.googleapis.com",              # bucket
    "artifactregistry.googleapis.com",     # Docker repo
    "run.googleapis.com",                  # Cloud Run
    "aiplatform.googleapis.com",           # Vertex AI (gitlab-ci has aiplatform.user)
  ]
}

resource "google_project_service" "required" {
  for_each = toset(local.required_apis)

  service            = each.value
  disable_on_destroy = false
}


