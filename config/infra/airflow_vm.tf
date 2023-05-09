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
  mkdir /git && mkdir /git/gce && \
  export GOOGLE_APPLICATION_CREDENTIALS=$(curl -s "http://metadata.google.internal/computeMetadata/v1/instance/attributes/TF_VAR_GOOGLE_APPLICATION_CREDENTIALS" -H "Metadata-Flavor: Google")
  echo $GOOGLE_APPLICATION_CREDENTIALS > /git/test_env_var.txt && \
  gsutil rsync -r gs://dataflow_jose /git/gce && \
  echo "sudo gsutil rsync -r gs://dataflow_jose /git/gce" >> /git/sync.sh && \
  echo "*/5 * * * * sudo gsutil rsync -r gs://dataflow_jose /git/gce" | crontab -
  echo "teste"
  SCRIPT

}
