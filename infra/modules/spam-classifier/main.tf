
#2. artifact registry repo to store images 
resource "google_artifact_registry_repository" "spam_classifier" {
  location      = var.region
  repository_id = var.service_name
  format        = "DOCKER"
  description   = "Docker repository for spam classifier"

  depends_on = [google_project_service.required] 
}

#1. GCS bucket for datasets

resource "google_storage_bucket" "ml_bucket" {
  name                        = var.bucket_name
  location                    = upper(var.region)
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true
  force_destroy               = false

  soft_delete_policy {
    retention_duration_seconds = 604800
  }

  depends_on = [google_project_service.required] 
  labels = {
    project    = var.service_name
    managed-by = "terraform"
  }
}


#7.cloud run service

resource "google_cloud_run_v2_service" "spam_classifier" {
  name     = var.service_name
  location = var.region

  ingress = "INGRESS_TRAFFIC_ALL"

  scaling {
    min_instance_count    = 0
    manual_instance_count = 0
  }

  template {
    service_account = google_service_account.runtime.email

    timeout                          = "300s"
    max_instance_request_concurrency = 80

    scaling {
      max_instance_count = 20
    }

    containers {
      image = "us-docker.pkg.dev/cloudrun/container/hello" #placeholder image until gitlab CI deploys first image

      ports {
        container_port = 8080
      }

      resources {
        limits = {
          cpu    = "1000m"
          memory = "512Mi"
        }
        cpu_idle          = true
        startup_cpu_boost = true

      }
    }
  }

  lifecycle {
    ignore_changes = [
      template[0].containers[0].image,
      client,
      client_version,
    ]
  }

  depends_on = [google_project_service.required] 
}


#3. service account used by GitLab CI
resource "google_service_account" "gitlab_ci" {
  account_id   = "gitlab-ci"
  display_name = "GitLab CI"

  depends_on = [google_project_service.required] 
}

#4. service account Cloud Run runs as
resource "google_service_account" "runtime" {
  account_id   = "spam-classifier-runtime"
  display_name = "Spam Classifier Runtime"
  description  = "Runtime identity for the spam-classifier Cloud Run service"

  depends_on = [google_project_service.required] 
}



#5. Workload Identity pool for GitLab CI
resource "google_iam_workload_identity_pool" "gitlab" {
  workload_identity_pool_id = "gitlab-pool"
  display_name              = "GitLab CI Pool"

  depends_on = [google_project_service.required] 
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
    "attribute.ref_path"     = "assertion.ref_path"
  }

  attribute_condition = "assertion.project_path=='${var.gitlab_project_path}'"

  oidc {
    issuer_uri = var.gitlab_url
  }
}

