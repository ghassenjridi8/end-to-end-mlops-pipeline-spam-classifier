variable "project_id" {
  description = "Google Cloud project ID"
  type        = string
  default     = "project-46677838-a710-49db-be5"
}


variable "region" {
  description = "Google Cloud region for regional resources"
  type        = string
  default     = "europe-west3"
}


#Application
variable "service_name" {
  description = "Base name for the Cloud Run service, Artifact Registry repo, image and runtime service account"
  type        = string
  default     = "spam-classifier"
}

variable "bucket_name" {
  description = "Name of the GCS bucket for datasets"
  type        = string
}

#GitLab
variable "gitlab_project_path" {
  description = "GitLab project allowed to authenticate via Workload Identity Federation (e.g. group/project)"
  type        = string
}

variable "gitlab_url" {
  description = "GitLab instance URL, used as the OIDC issuer"
  type        = string
  default     = "https://gitlab.com"
}
