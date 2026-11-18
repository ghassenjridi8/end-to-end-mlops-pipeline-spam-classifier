output "service_url" {
  description = "Public URL of the Cloud Run service"
  value       = module.spam_classifier.service_url
}

output "image_repository" {
  description = "Docker image path (without tag) that CI pushes to"
  value       = module.spam_classifier.image_repository
}