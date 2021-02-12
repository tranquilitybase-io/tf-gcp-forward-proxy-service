## Module Overview

Terraform module for creating networking resources on Google Cloud Platform (GCP).

It deploys the following resources into a given GCP project:

- Instance Template
- Managed Instance Group
- Service Account (optional)
- Service Account permissions


## Requirements

| Name | Version |
|------|---------|
| terraform | >=0.13.4,<0.15 |
| google | <4.0,>= 2.12 |

## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| health\_check | Health check for mig | <pre>object({<br>    type                = string<br>    initial_delay_sec   = number<br>    check_interval_sec  = number<br>    healthy_threshold   = number<br>    timeout_sec         = number<br>    unhealthy_threshold = number<br>    response            = string<br>    proxy_header        = string<br>    port                = number<br>    request             = string<br>    request_path        = string<br>    host                = string<br>  })</pre> | <pre>{<br>  "check_interval_sec": 30,<br>  "healthy_threshold": 1,<br>  "host": "",<br>  "initial_delay_sec": 300,<br>  "port": 3128,<br>  "proxy_header": "NONE",<br>  "request": "",<br>  "request_path": "/",<br>  "response": "",<br>  "timeout_sec": 10,<br>  "type": "",<br>  "unhealthy_threshold": 5<br>}</pre> | no |
| mig\_hostname | Hostname of mig | `string` | `"forward-proxy-mig"` | no |
| network\_self\_link | Network self link | `string` | n/a | yes |
| node\_count | Number of instances to deploy | `string` | `"1"` | no |
| preemptive | Create preemptive forward proxy instance | `bool` | `false` | no |
| project\_id | project id | `string` | n/a | yes |
| region | Region | `string` | n/a | yes |
| service\_account\_name | Name of service account attached to forward proxy instance | `string` | `""` | no |
| subnets\_name | Subnet name | `string` | n/a | yes |
| template\_name | Name of template used by mig | `string` | `"forward-proxy-template"` | no |

## Outputs

| Name | Description |
|------|-------------|
| instance\_tempalte\_name | Instance template name |
| instance\_template\_self\_link | Self link for instance template |
| mig\_instance\_group\_url | Url for mig instance group |
| mig\_self\_link | Self link for mig |

