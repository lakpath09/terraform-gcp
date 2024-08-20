terraform {
  required_version = ">= 0.12"
}
provider "google" {
  credentials = file("service-account.json")
  project     = "devopscube-demo"
  region      = "us-central1"
  zone        = "us-central1-c"
}

resource "google_compute_instance" "lakpath" {

  name         = "devopscube-demo-instance"
  machine_type = "f1-micro"
  zone         = "us-west1-a"
  boot_disk {
    auto_delete = false
    initialize_params {
      image = "ubuntu-1604-xenial-v20181023"
      size  = "30"
    }
  }



network_interface {
   network = "default"
   access_config {}
}


metadata_startup_script = "echo demo > /demo.txt"

scheduling {
    preemptible       = true
  }

service_account {
   scopes = ["cloud-platform"]
   }
}

