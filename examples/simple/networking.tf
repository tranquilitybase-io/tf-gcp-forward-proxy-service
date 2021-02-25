data "google_netblock_ip_ranges" "legacy_healthcheck" {
  range_type = "legacy-health-checkers"
}

data "google_netblock_ip_ranges" "iap" {
  range_type = "iap-forwarders"
}

resource "google_compute_network" "network" {
  name    = "example-network"
  project = var.project_id
}

resource "google_compute_router" "router" {
  name    = "example-router"
  project = var.project_id
  region  = var.region
  network = google_compute_network.network.self_link
}

resource "google_compute_router_nat" "nat" {
  name                               = "example-nat"
  project                            = var.project_id
  router                             = google_compute_router.router.name
  region                             = google_compute_router.router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}

resource "google_compute_subnetwork" "subnet" {
  name          = "example-subnetwork"
  ip_cidr_range = "10.64.0.0/16"
  region        = "europe-west1"
  network       = google_compute_network.network.id
  project       = var.project_id
}

resource "google_compute_firewall" "allow_iap_ssh" {
  name          = "allow-iap-ssh"
  description   = "Allow incoming IAP traffic"
  network       = google_compute_network.network.self_link
  source_ranges = data.google_netblock_ip_ranges.iap.cidr_blocks_ipv4
  target_tags   = ["allow-iap-ssh"]
  project       = var.project_id
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}

resource "google_compute_firewall" "allow_proxy_healthcheck" {
  name          = "allow-proxy-healthcheck"
  description   = "Allow incoming healthcheck traffic"
  network       = google_compute_network.network.self_link
  source_ranges = data.google_netblock_ip_ranges.legacy_healthcheck.cidr_blocks_ipv4
  target_tags   = ["allow-proxy-healthcheck"]
  project       = var.project_id
  allow {
    protocol = "tcp"
    ports    = ["3128"]
  }
}
