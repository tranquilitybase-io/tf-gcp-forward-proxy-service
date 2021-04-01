data "google_compute_zones" "available" {
  project = var.project_id
  region  = var.region
  status  = "UP"
}

resource "time_sleep" "wait_120_seconds" {
  depends_on = [module.mig]

  create_duration = "1s"
}

data "google_compute_instance_group" "mig_instances" {
  name    = format("%s-%s", var.mig_hostname, "mig")
  project = var.project_id
  zone    = data.google_compute_zones.available.names[0]

  depends_on = [time_sleep.wait_120_seconds]
}