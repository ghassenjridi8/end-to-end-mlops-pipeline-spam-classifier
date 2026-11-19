# 8. GitLab CI can deploy Cloud Run services
resource "google_project_iam_member" "gitlab_ci_run_developer" {
  project = var.project_id
  role    = "roles/run.developer"
  member  = google_service_account.gitlab_ci.member
}

# 9. GitLab CI can use Vertex AI
resource "google_project_iam_member" "gitlab_ci_aiplatform_user" {
  project = var.project_id
  role    = "roles/aiplatform.user"
  member  = google_service_account.gitlab_ci.member
}


# 10. GitLab CI can read/write objects in the ML bucket (datasets, models)
resource "google_storage_bucket_iam_member" "gitlab_ci_bucket_object_admin" {
  bucket = google_storage_bucket.ml_bucket.name
  role   = "roles/storage.objectAdmin"
  member = google_service_account.gitlab_ci.member
}

# 10b. objectAdmin already covers this
  resource "google_storage_bucket_iam_member" "gitlab_ci_bucket_object_viewer" {
    bucket = google_storage_bucket.ml_bucket.name
    role   = "roles/storage.objectViewer"
    member = google_service_account.gitlab_ci.member
  }


# 11. GitLab CI can push images to the Artifact Registry repo
resource "google_artifact_registry_repository_iam_member" "gitlab_ci_ar_writer" {
  location   = google_artifact_registry_repository.spam_classifier.location
  repository = google_artifact_registry_repository.spam_classifier.name
  role       = "roles/artifactregistry.writer"
  member     = google_service_account.gitlab_ci.member
}



# 12. Pipeline from the GitLab project ghassenjridi8/spam-classifier can impersonate the GitLab CI SA
resource "google_service_account_iam_member" "gitlab_ci_wif_user" {
  service_account_id = google_service_account.gitlab_ci.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.gitlab.name}/attribute.project_path/${var.gitlab_project_path}"
}

# 13. GitLab CI can deploy Cloud Run with the runtime SA as the service identity
resource "google_service_account_iam_member" "gitlab_ci_acts_as_runtime" {
  service_account_id = google_service_account.runtime.name
  role               = "roles/iam.serviceAccountUser"
  member             = google_service_account.gitlab_ci.member
}


# 14. public users can invoke the cloud run service 
resource "google_cloud_run_v2_service_iam_member" "public_invoker" {
  project  = var.project_id
  location = var.region
  name     = google_cloud_run_v2_service.spam_classifier.name

  role   = "roles/run.invoker"
  member = "allUsers"
}

# Extra readers of this environment's image repo (used to promote images to prod)
resource "google_artifact_registry_repository_iam_member" "image_readers" {
  for_each = toset(var.image_readers)

  location   = google_artifact_registry_repository.spam_classifier.location
  repository = google_artifact_registry_repository.spam_classifier.name
  role       = "roles/artifactregistry.reader"
  member     = each.value
}


