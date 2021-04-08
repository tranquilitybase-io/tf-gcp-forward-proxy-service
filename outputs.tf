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

output "instance_template_self_link" {
  description = "Self link for instance template"
  value       = module.instance-template.self_link
}

output "instance_template_name" {
  description = "Instance template name"
  value       = module.instance-template.name
}

output "mig_self_link" {
  description = "Self link for mig"
  value       = module.mig.self_link
}

output "mig_instance_group_url" {
  description = "Url for mig instance group"
  value       = module.mig.instance_group
}

output "mig_instance_zone" {
  value = data.google_compute_zones.available.names[0]
}

output "mig_name" {
  value = format("%s-%s", var.mig_hostname, "mig")
}

output "forward_proxy_name" {
  value = data.local_file.get_forward_proxy_instance_name.content
}
