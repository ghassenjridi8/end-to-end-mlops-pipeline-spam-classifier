terraform {
  required_version = ">= 1.5.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.0"
    }

    gitlab = {
      source = "gitlabhq/gitlab"
      version = "~> 19.5"
    }

  }
}
