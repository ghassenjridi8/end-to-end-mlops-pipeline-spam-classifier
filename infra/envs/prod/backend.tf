terraform {
  backend "gcs" {
    bucket = "spam-classifier-tfstate-773233738701" #set your own state bucket
    prefix = "terraform/state"
  }
}


