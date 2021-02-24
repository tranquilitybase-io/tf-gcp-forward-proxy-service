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

variable "health_check" {
  description = "Health check for mig"
  type = object({
    type                = string
    initial_delay_sec   = number
    check_interval_sec  = number
    healthy_threshold   = number
    timeout_sec         = number
    unhealthy_threshold = number
    response            = string
    proxy_header        = string
    port                = number
    request             = string
    request_path        = string
    host                = string
  })
  default = {
    "check_interval_sec" : 30,
    "healthy_threshold" : 1,
    "host" : "",
    "initial_delay_sec" : 300,
    "port" : 3128,
    "proxy_header" : "NONE",
    "request" : "",
    "request_path" : "/",
    "response" : "",
    "timeout_sec" : 10,
    "type" : "",
    "unhealthy_threshold" : 5
  }
}

variable "mig_hostname" {
  description = "Hostname of mig"
  type        = string
  default     = "forward-proxy"
}

variable "machine_type" {
  description = "Machine type for template"
  type        = string
  default     = "e2-small"
}

variable "network_name" {
  description = "Network self link"
  type        = string
  default     = ""
}

variable "node_count" {
  description = "Number of instances to deploy"
  type        = string
  default     = "1"
}

variable "preemptible" {
  description = "Create preemptive forward proxy instance"
  type        = bool
  default     = false
}

variable "project_id" {
  description = "Project id"
  type        = string
}

variable "region" {
  description = "Region"
  type        = string
}

variable "service_account_name" {
  description = "Name of service account attached to forward proxy instance"
  type        = string
  default     = ""
}

variable "source_image_family" {
  description = "Source image family for template"
  type        = string
  default     = "debian-9"
}

variable "source_image_project" {
  description = "Source image project"
  type        = string
  default     = "debian-cloud"
}

variable "subnet_name" {
  description = "Subnet name"
  type        = string
}

variable "template_name" {
  description = "Name of template used by mig"
  type        = string
  default     = "forward-proxy"
}

