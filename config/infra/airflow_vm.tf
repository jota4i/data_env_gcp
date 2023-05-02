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
  sudo apt-get install -y git && \
  mkdir /git && \
  cd /git && \
  git clone https://github.com/jota4i/data_env_gcp.git && \
  cd data_env_gcp && \
  sudo chmod a+x config/infra/config.sh
  SCRIPT

}
