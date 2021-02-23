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

locals {
  sa_email_role_format   = format("%s:%s@%s.%s", "serviceAccount", local.sa_name, var.project_id, "iam.gserviceaccount.com")
  sa_name                = var.service_account_name != "" ? var.service_account_name : "forwardproxy"
  service_account_email  = format("%s@%s.%s", local.sa_name, var.project_id, "iam.gserviceaccount.com")
  service_account_object = { email = local.service_account_email, scopes = ["cloud-platform"] }
}
