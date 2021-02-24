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

module "forwardproxy" {
  source = "../.."

  subnet_name  = google_compute_subnetwork.subnet.name
  network_name = google_compute_network.network.name
  region       = var.region
  project_id   = var.project_id
  target_tags  = ["allow-iap-ssh"]
}

