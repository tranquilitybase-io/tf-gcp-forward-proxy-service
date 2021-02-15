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
  source = "terraform-google-modules/vm/google//modules/instance_template"
  version = "6.0.0"

  name_prefix        = var.template_name
  project_id         = var.project_id
  network            = var.network_self_link
  subnetwork         = var.subnet_name
  subnetwork_project = var.project_id
  service_account    = local.service_account_object
  tags               = ["iap"]

  preemptible    = var.preemptive
  startup_script = file("${path.module}/files/metadata-startup.sh")
  region         = var.region

  depends_on = [module.service-account]
}

module "mig" {
  source = "terraform-google-modules/vm/google//modules/mig"
  version = "6.0.0"

  project_id        = var.project_id
  hostname          = var.mig_hostname
  instance_template = module.instance-template.self_link
  subnetwork        = var.subnet_name
  region            = var.region
  network           = var.network_self_link
  target_size       = var.node_count
  health_check      = var.health_check

}
