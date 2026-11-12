
#2. artifact registry repo to store images 
resource "google_artifact_registry_repository" "spam_classifier" {
  location      = location = var.region
  repository_id = "spam-classifier"
  format        = "DOCKER"
  description   = "Docker repository for spam classifier"
}

#1. GCS bucket for datasets

resource "google_storage_bucket" "ml_bucket" {
  name                        = "spam-classifier-mlops-project-ghassen"
  location                    = upper(var.region)
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true
  force_destroy               = false

  soft_delete_policy {
    retention_duration_seconds = 604800
  }
}


#7.cloud run service

resource "google_cloud_run_v2_service" "spam_classifier" {
  name     = "spam-classifier"
  location = "europe-west3"

  ingress = "INGRESS_TRAFFIC_ALL"

  template {
    service_account = "spam-classifier-runtime@project-46677838-a710-49db-be5.iam.gserviceaccount.com"

    timeout                          = "300s"
    max_instance_request_concurrency = 80

    scaling {
      max_instance_count = 20
    }

    containers {
      image = "europe-west3-docker.pkg.dev/project-46677838-a710-49db-be5/spam-classifier/spam-classifier:51e75f64d7b8a80b7e4652fe9607951f9a5ece5b"

      ports {
        container_port = 8080
      }

      resources {
        limits = {
          cpu    = "1"
          memory = "512Mi"
        }
      }
    }
  }

  lifecycle {
    ignore_changes = [
      template[0].containers[0].image
    ]
  }
}


#3. service account used by GitLab CI
resource "google_service_account" "gitlab_ci" {
  account_id   = "gitlab-ci"
  display_name = "GitLab CI"
}

#4. service account Cloud Run runs as
resource "google_service_account" "runtime" {
  account_id   = "spam-classifier-runtime"
  display_name = "Spam Classifier Runtime"
  description  = "Runtime identity for the spam-classifier Cloud Run service"
}



#5. Workload Identity pool for GitLab CI
resource "google_iam_workload_identity_pool" "gitlab" {
  workload_identity_pool_id = "gitlab-pool"
  display_name              = "GitLab CI Pool"
}


#6. OIDC provider that trusts GitLab's tokens
resource "google_iam_workload_identity_pool_provider" "gitlab" {
  workload_identity_pool_id          = google_iam_workload_identity_pool.gitlab.workload_identity_pool_id
  workload_identity_pool_provider_id = "gitlab-provider"
  display_name                       = "GitLab OIDC Provider"

  attribute_mapping = {
    "google.subject"         = "assertion.sub"
    "attribute.project_path" = "assertion.project_path"
    "attribute.ref"          = "assertion.ref"
  }

  attribute_condition = "assertion.project_path=='ghassenjridi8/spam-classifier'"

  oidc {
    issuer_uri = "https://gitlab.com"
  }
}

