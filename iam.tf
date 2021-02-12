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

module "service-account" {
  source = "terraform-google-modules/service-accounts/google"
  count  = var.service_account_name != "" ? 0 : 1

  project_id    = var.project_id
  names         = [local.sa_name]
  project_roles = []
}

module "project-iam-bindings" {
  source   = "terraform-google-modules/iam/google//modules/projects_iam"
  projects = [var.project_id]
  mode     = "additive"

  bindings = {
    "roles/logging.logWriter" = [
      local.sa_email_role_format,
    ]
    "roles/monitoring.metricWriter" = [
      local.sa_email_role_format,
    ]
    "roles/monitoring.viewer" = [
      local.sa_email_role_format,
    ]
    "roles/stackdriver.resourceMetadata.writer" = [
      local.sa_email_role_format,
    ]
  }

  depends_on = [module.service-account]
}
