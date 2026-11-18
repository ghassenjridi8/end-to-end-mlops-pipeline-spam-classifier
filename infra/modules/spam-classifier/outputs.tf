output "service_url" {
  description = "Public URL of the Cloud Run service"
  value       = google_cloud_run_v2_service.spam_classifier.uri
}

output "image_repository" {
  description = "Docker image path (without tag) that CI pushes to"
  value       = "${var.region}-docker.pkg.dev/${var.project_id}/${google_artifact_registry_repository.spam_classifier.repository_id}/${var.service_name}"
}
