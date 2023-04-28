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
}
