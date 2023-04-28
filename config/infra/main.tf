resource "google_storage_bucket" "default" {
  name          = "data-pipeline-bucket-tfstate"
  force_destroy = false
  location      = "US"
  storage_class = "STANDARD"
  versioning {
    enabled = false
  }
}
