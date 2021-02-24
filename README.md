## Module Overview

Terraform module for creating a forward proxy on the Google Cloud Platform (GCP).

It deploys the following resources into a given GCP project:

- Instance Template
- Managed Instance Group
- Service Account (optional)
- Service Account permissions

## Requirements

| Name | Version |
|------|---------|
| terraform | >=0.14.2,<0.15 |
| google | <4.0,>= 2.12 |

## Usage
Refer to the examples under [examples/](examples) directory.

## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| disk\_size\_gb | Boot disk size in GB | `string` | `"50"` | no |
| health\_check | Health check for mig | <pre>object({<br>    type                = string<br>    initial_delay_sec   = number<br>    check_interval_sec  = number<br>    healthy_threshold   = number<br>    timeout_sec         = number<br>    unhealthy_threshold = number<br>    response            = string<br>    proxy_header        = string<br>    port                = number<br>    request             = string<br>    request_path        = string<br>    host                = string<br>  })</pre> | <pre>{<br>  "check_interval_sec": 30,<br>  "healthy_threshold": 1,<br>  "host": "",<br>  "initial_delay_sec": 300,<br>  "port": 3128,<br>  "proxy_header": "NONE",<br>  "request": "",<br>  "request_path": "/",<br>  "response": "",<br>  "timeout_sec": 10,<br>  "type": "tcp",<br>  "unhealthy_threshold": 5<br>}</pre> | no |
| machine\_type | Machine type for template | `string` | `"e2-small"` | no |
| mig\_hostname | Hostname of mig | `string` | `"forward-proxy"` | no |
| network\_name | Network self link | `string` | `""` | no |
| node\_count | Number of instances to deploy | `string` | `"1"` | no |
| preemptible | Create preemptive forward proxy instance | `bool` | `false` | no |
| project\_id | Project id | `string` | n/a | yes |
| region | Region | `string` | n/a | yes |
| service\_account\_name | Name of service account attached to forward proxy instance | `string` | `""` | no |
| source\_image\_family | Source image family for template | `string` | `"debian-10"` | no |
| source\_image\_project | Source image project | `string` | `"debian-cloud"` | no |
| subnet\_name | Subnet name | `string` | n/a | yes |
| target\_tags | Target tags | `list(any)` | `[]` | no |
| template\_name | Name of template used by mig | `string` | `"forward-proxy"` | no |

## Outputs

| Name | Description |
|------|-------------|
| instance\_template\_name | Instance template name |
| instance\_template\_self\_link | Self link for instance template |
| mig\_instance\_group\_url | Url for mig instance group |
| mig\_self\_link | Self link for mig |

