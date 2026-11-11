terraform {
  backend "gcs" {
    bucket = "spam-classifier-tfstate-773233738701"
    prefix = "terraform/state"
  }
}
