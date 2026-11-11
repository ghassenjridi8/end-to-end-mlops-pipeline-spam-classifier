resource "google_artifact_registry_repository" "spam_classifier" {
  location      = "europe-west3"
  repository_id = "spam-classifier"
  format        = "DOCKER"
  description   = "Docker repository for spam classifier"
}
