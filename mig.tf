# Copyright 2021 The Tranquility Base Authors
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

module "instance-template" {
  source  = "terraform-google-modules/vm/google//modules/instance_template"
  version = "6.0.0"

  disk_size_gb         = var.disk_size_gb
  machine_type         = var.machine_type
  name_prefix          = var.template_name
  network              = var.network_name
  preemptible          = var.preemptible
  project_id           = var.project_id
  region               = var.region
  service_account      = local.service_account_object
  source_image_family  = var.source_image_family
  source_image_project = var.source_image_project
  startup_script       = file("${path.module}/files/metadata-startup.sh")
  subnetwork           = var.subnet_name
  subnetwork_project   = var.project_id
  tags                 = var.tags

  depends_on = [module.service-account]
}

module "mig" {
  source  = "terraform-google-modules/vm/google//modules/mig"
  version = "6.0.0"

  //distribution_policy_zones = [data.google_compute_zones.available.names[0]]
  health_check              = var.health_check
  hostname                  = var.mig_hostname
  instance_template         = module.instance-template.self_link
  network                   = var.network_name
  project_id                = var.project_id
  region                    = var.region
  subnetwork                = var.subnet_name
  target_size               = var.node_count

}

resource "null_resource" "get_forward_proxy_instance_name" {
  triggers = {
    always = timestamp()
  }
  provisioner "local-exec" {
    command = "gcloud compute instances list --filter=\"name~'forward-proxy-*'\" --format=\"value(name)\" | tr -d '\n' >> ${path.module}/forward_proxy_instance_name.txt"
  }
  depends_on = [module.mig]
}

resource "null_resource" "get_forward_proxy_instance_zone" {
  triggers = {
    always = timestamp()
  }
  provisioner "local-exec" {
    command = "gcloud compute instances list --filter=\"name~'forward-proxy-*'\" --format=\"value(zone)\" | tr -d '\n' >> ${path.module}/forward_proxy_instance_zone.txt"
  }
  depends_on = [module.mig]
}

data "local_file" "get_forward_proxy_instance_name" {
  filename = "${path.module}/forward_proxy_instance_name.txt"
  depends_on = [null_resource.get_forward_proxy_instance_name]
}

data "local_file" "get_forward_proxy_instance_zone" {
  filename = "${path.module}/forward_proxy_instance_zone.txt"
  depends_on = [null_resource.get_forward_proxy_instance_zone]
}