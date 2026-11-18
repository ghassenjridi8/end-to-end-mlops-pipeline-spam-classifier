terraform {
  backend "gcs" {
    bucket = "spam-classifier-staging-tfstate-445535388698" #set your own state bucket
    prefix = "terraform/state"
  }
}


