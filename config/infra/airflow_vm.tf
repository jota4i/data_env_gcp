resource "google_compute_instance" "vm_instance" {
  name         = "airflow-server"
  machine_type = "e2-micro"

  boot_disk {
    initialize_params {
      image = "projects/debian-cloud/global/images/debian-11-bullseye-v20230411"
    }
  }
  network_interface {
    network = "default"
    access_config {
    }
  }
  metadata_startup_script = <<-SCRIPT
  gsutil rsync -r gs://dataflow_jose /git/gce && \
  echo "sudo gsutil rsync -r gs://dataflow_jose /git/gce" >> /git/sync.sh && \
  echo "*/5 * * * * sudo gsutil rsync -r gs://dataflow_jose /git/gce" | crontab -
  SCRIPT

}
