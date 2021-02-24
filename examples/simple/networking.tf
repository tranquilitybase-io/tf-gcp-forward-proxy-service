resource "google_compute_network" "network" {
  name = "example-network"
  project = var.project_id
}

resource "google_compute_subnetwork" "subnet" {
  name          = "example-subnetwork"
  ip_cidr_range = "10.2.0.0/16"
  region        = "europe-west1"
  network       = google_compute_network.network.id
  project       = var.project_id
}

resource "google_compute_firewall" "allow_iap_ssh" {
  name        = "allow-iap-ssh"
  description = "Allow incoming IAP traffic"
  network     = google_compute_network.network.self_link
  source_ranges = ["35.235.240.0/20"]
  target_tags = ["allow-iap-ssh"]
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}
