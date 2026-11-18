# Resources moved from the old flat infra/ layout into the spam_classifier module.
# These blocks can be deleted once the move has been applied.

# --- main.tf ---
moved {
  from = google_storage_bucket.ml_bucket
  to   = module.spam_classifier.google_storage_bucket.ml_bucket
}
moved {
  from = google_artifact_registry_repository.spam_classifier
  to   = module.spam_classifier.google_artifact_registry_repository.spam_classifier
}
moved {
  from = google_cloud_run_v2_service.spam_classifier
  to   = module.spam_classifier.google_cloud_run_v2_service.spam_classifier
}
moved {
  from = google_service_account.gitlab_ci
  to   = module.spam_classifier.google_service_account.gitlab_ci
}
moved {
  from = google_service_account.runtime
  to   = module.spam_classifier.google_service_account.runtime
}
moved {
  from = google_iam_workload_identity_pool.gitlab
  to   = module.spam_classifier.google_iam_workload_identity_pool.gitlab
}
moved {
  from = google_iam_workload_identity_pool_provider.gitlab
  to   = module.spam_classifier.google_iam_workload_identity_pool_provider.gitlab
}

# --- iam.tf ---
moved {
  from = google_project_iam_member.gitlab_ci_run_developer
  to   = module.spam_classifier.google_project_iam_member.gitlab_ci_run_developer
}
moved {
  from = google_project_iam_member.gitlab_ci_aiplatform_user
  to   = module.spam_classifier.google_project_iam_member.gitlab_ci_aiplatform_user
}
moved {
  from = google_storage_bucket_iam_member.gitlab_ci_bucket_object_admin
  to   = module.spam_classifier.google_storage_bucket_iam_member.gitlab_ci_bucket_object_admin
}
moved {
  from = google_storage_bucket_iam_member.gitlab_ci_bucket_object_viewer
  to   = module.spam_classifier.google_storage_bucket_iam_member.gitlab_ci_bucket_object_viewer
}
moved {
  from = google_artifact_registry_repository_iam_member.gitlab_ci_ar_writer
  to   = module.spam_classifier.google_artifact_registry_repository_iam_member.gitlab_ci_ar_writer
}
moved {
  from = google_service_account_iam_member.gitlab_ci_wif_user
  to   = module.spam_classifier.google_service_account_iam_member.gitlab_ci_wif_user
}
moved {
  from = google_service_account_iam_member.gitlab_ci_acts_as_runtime
  to   = module.spam_classifier.google_service_account_iam_member.gitlab_ci_acts_as_runtime
}
moved {
  from = google_cloud_run_v2_service_iam_member.public_invoker
  to   = module.spam_classifier.google_cloud_run_v2_service_iam_member.public_invoker
}

# --- services.tf ---
moved {
  from = google_project_service.required
  to   = module.spam_classifier.google_project_service.required
}

# --- gitlab.tf ---
moved {
  from = gitlab_project_variable.ci
  to   = module.spam_classifier.gitlab_project_variable.ci
}

# --- terraform-ci.tf ---
moved {
  from = google_service_account.terraform_plan
  to   = module.spam_classifier.google_service_account.terraform_plan
}
moved {
  from = google_service_account.terraform_apply
  to   = module.spam_classifier.google_service_account.terraform_apply
}
moved {
  from = google_project_iam_member.terraform_plan_viewer
  to   = module.spam_classifier.google_project_iam_member.terraform_plan_viewer
}
moved {
  from = google_project_iam_member.terraform_plan_security_reviewer
  to   = module.spam_classifier.google_project_iam_member.terraform_plan_security_reviewer
}
moved {
  from = google_storage_bucket_iam_member.terraform_plan_state
  to   = module.spam_classifier.google_storage_bucket_iam_member.terraform_plan_state
}
moved {
  from = google_project_iam_member.terraform_apply
  to   = module.spam_classifier.google_project_iam_member.terraform_apply
}
moved {
  from = google_service_account_iam_member.terraform_apply_acts_as_runtime
  to   = module.spam_classifier.google_service_account_iam_member.terraform_apply_acts_as_runtime
}
moved {
  from = google_service_account_iam_member.terraform_plan_wif_user
  to   = module.spam_classifier.google_service_account_iam_member.terraform_plan_wif_user
}
moved {
  from = google_service_account_iam_member.terraform_apply_wif_user
  to   = module.spam_classifier.google_service_account_iam_member.terraform_apply_wif_user
}
moved {
  from = google_secret_manager_secret.gitlab_token
  to   = module.spam_classifier.google_secret_manager_secret.gitlab_token
}
moved {
  from = google_secret_manager_secret_iam_member.terraform_apply_gitlab_token
  to   = module.spam_classifier.google_secret_manager_secret_iam_member.terraform_apply_gitlab_token
}