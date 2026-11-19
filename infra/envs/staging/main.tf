# Staging environment: all resources come from the shared module,
# the environment's values from terraform.tfvars
module "spam_classifier" {
  source = "../../modules/spam-classifier"

  project_id          = var.project_id
  region              = var.region
  service_name        = var.service_name
  bucket_name         = var.bucket_name
  gitlab_project_path = var.gitlab_project_path
  gitlab_url          = var.gitlab_url
  gitlab_apply_branch = var.gitlab_apply_branch
  tf_state_bucket     = var.tf_state_bucket
  gitlab_environment_scope = "staging"
  image_readers = ["serviceAccount:gitlab-ci@${var.prod_project_id}.iam.gserviceaccount.com"] ## prod's deploy SA copies the tested image from this registry to prod's
}




