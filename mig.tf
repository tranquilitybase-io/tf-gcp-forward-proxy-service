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

  machine_type         = var.machine_type
  name_prefix          = var.template_name
  network              = var.network_name
  preemptible          = var.preemptible
  project_id           = var.project_id
  region               = var.region
  source_image_family  = var.source_image_family
  source_image_project = var.source_image_project
  subnetwork           = var.subnet_name
  subnetwork_project   = var.project_id
  service_account      = local.service_account_object
  startup_script       = file("${path.module}/files/metadata-startup.sh")
  tags                 = var.target_tags

  depends_on = [module.service-account]
}

module "mig" {
  source  = "terraform-google-modules/vm/google//modules/mig"
  version = "6.0.0"

  health_check      = var.health_check
  hostname          = var.mig_hostname
  instance_template = module.instance-template.self_link
  network           = var.network_name
  project_id        = var.project_id
  region            = var.region
  subnetwork        = var.subnet_name
  target_size       = var.node_count
}
