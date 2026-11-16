variable "project_id" {
  description = "Google Cloud project ID"
  type        = string
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

variable "tf_state_bucket" {
  description = "Existing GCS bucket holding the Terraform state (same as in backend.hcl)"
  type        = string
}

variable "gitlab_apply_branch" {
  description = "Only pipelines on this branch may use the terraform-apply service account"
  type        = string
  default     = "main"
}