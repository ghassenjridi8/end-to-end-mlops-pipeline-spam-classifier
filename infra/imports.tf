##resources imports
#1
import {
  to = google_storage_bucket.ml_bucket
  id = "spam-classifier-mlops-project-ghassen"
}

#2
import {
  to = google_artifact_registry_repository.spam_classifier
  id = "projects/project-46677838-a710-49db-be5/locations/europe-west3/repositories/spam-classifier"
}

#3
import {
  to = google_service_account.gitlab_ci
  id = "projects/project-46677838-a710-49db-be5/serviceAccounts/gitlab-ci@project-46677838-a710-49db-be5.iam.gserviceaccount.com"
}

#4
import {
  to = google_service_account.runtime
  id = "projects/project-46677838-a710-49db-be5/serviceAccounts/spam-classifier-runtime@project-46677838-a710-49db-be5.iam.gserviceaccount.com"
}

#5
import {
  to = google_iam_workload_identity_pool.gitlab
  id = "projects/project-46677838-a710-49db-be5/locations/global/workloadIdentityPools/gitlab-pool"
}

#6
import {
  to = google_iam_workload_identity_pool_provider.gitlab
  id = "projects/project-46677838-a710-49db-be5/locations/global/workloadIdentityPools/gitlab-pool/providers/gitlab-provider"
}

#7
import {
  to = google_cloud_run_v2_service.spam_classifier
  id = "projects/project-46677838-a710-49db-be5/locations/europe-west3/services/spam-classifier"
}

##iam bindings imports
# 8
import {
  to = google_project_iam_member.gitlab_ci_run_developer
  id = "project-46677838-a710-49db-be5 roles/run.developer serviceAccount:gitlab-ci@project-46677838-a710-49db-be5.iam.gserviceaccount.com"
}

# 9
import {
  to = google_project_iam_member.gitlab_ci_aiplatform_user
  id = "project-46677838-a710-49db-be5 roles/aiplatform.user serviceAccount:gitlab-ci@project-46677838-a710-49db-be5.iam.gserviceaccount.com"
}

# 10
import {
  to = google_storage_bucket_iam_member.gitlab_ci_bucket_object_admin
  id = "b/spam-classifier-mlops-project-ghassen roles/storage.objectAdmin serviceAccount:gitlab-ci@project-46677838-a710-49db-be5.iam.gserviceaccount.com"
}

# 10b
import {
  to = google_storage_bucket_iam_member.gitlab_ci_bucket_object_viewer
  id = "b/spam-classifier-mlops-project-ghassen roles/storage.objectViewer serviceAccount:gitlab-ci@project-46677838-a710-49db-be5.iam.gserviceaccount.com"
}

# 11
import {
  to = google_artifact_registry_repository_iam_member.gitlab_ci_ar_writer
  id = "projects/project-46677838-a710-49db-be5/locations/europe-west3/repositories/spam-classifier roles/artifactregistry.writer serviceAccount:gitlab-ci@project-46677838-a710-49db-be5.iam.gserviceaccount.com"
}

# 12
import {
  to = google_service_account_iam_member.gitlab_ci_wif_user
  id = "projects/project-46677838-a710-49db-be5/serviceAccounts/gitlab-ci@project-46677838-a710-49db-be5.iam.gserviceaccount.com roles/iam.workloadIdentityUser principalSet://iam.googleapis.com/projects/773233738701/locations/global/workloadIdentityPools/gitlab-pool/attribute.project_path/ghassenjridi8/spam-classifier"
}

# 13
import {
  to = google_service_account_iam_member.gitlab_ci_acts_as_runtime
  id = "projects/project-46677838-a710-49db-be5/serviceAccounts/spam-classifier-runtime@project-46677838-a710-49db-be5.iam.gserviceaccount.com roles/iam.serviceAccountUser serviceAccount:gitlab-ci@project-46677838-a710-49db-be5.iam.gserviceaccount.com"
}

# 14
import {
  to = google_cloud_run_v2_service_iam_member.public_invoker
  id = "projects/project-46677838-a710-49db-be5/locations/europe-west3/services/spam-classifier roles/run.invoker allUsers"
}
