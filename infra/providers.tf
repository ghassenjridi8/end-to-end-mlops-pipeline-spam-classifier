provider "google" {
  project = var.project_id
  region  = var.region
}


provider "gitlab" {
  base_url = "${var.gitlab_url}/api/v4/"
  # token is read from the GITLAB_TOKEN environment variable
}


