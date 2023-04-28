terraform {
  backend "gcs" {
    bucket = "data-pipeline-bucket-tfstate"
    prefix = "terraform/state"
  }
}
