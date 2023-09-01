<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 3.59.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.59.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vpc"></a> [vpc](#module\_vpc) | ./modules/vpc | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_eip.eip-a](https://registry.terraform.io/providers/hashicorp/aws/3.59.0/docs/resources/eip) | resource |
| [aws_eip.eip-b](https://registry.terraform.io/providers/hashicorp/aws/3.59.0/docs/resources/eip) | resource |
| [aws_eip.eip-c](https://registry.terraform.io/providers/hashicorp/aws/3.59.0/docs/resources/eip) | resource |
| [aws_instance.server-a](https://registry.terraform.io/providers/hashicorp/aws/3.59.0/docs/resources/instance) | resource |
| [aws_instance.server-b](https://registry.terraform.io/providers/hashicorp/aws/3.59.0/docs/resources/instance) | resource |
| [aws_instance.server-c](https://registry.terraform.io/providers/hashicorp/aws/3.59.0/docs/resources/instance) | resource |
| [aws_lb.webserver-alb](https://registry.terraform.io/providers/hashicorp/aws/3.59.0/docs/resources/lb) | resource |
| [aws_lb_listener.front_end](https://registry.terraform.io/providers/hashicorp/aws/3.59.0/docs/resources/lb_listener) | resource |
| [aws_lb_target_group.web-servers](https://registry.terraform.io/providers/hashicorp/aws/3.59.0/docs/resources/lb_target_group) | resource |
| [aws_lb_target_group_attachment.web-server-01](https://registry.terraform.io/providers/hashicorp/aws/3.59.0/docs/resources/lb_target_group_attachment) | resource |
| [aws_lb_target_group_attachment.web-server-02](https://registry.terraform.io/providers/hashicorp/aws/3.59.0/docs/resources/lb_target_group_attachment) | resource |
| [aws_lb_target_group_attachment.web-server-03](https://registry.terraform.io/providers/hashicorp/aws/3.59.0/docs/resources/lb_target_group_attachment) | resource |
| [aws_network_interface.eni-a](https://registry.terraform.io/providers/hashicorp/aws/3.59.0/docs/resources/network_interface) | resource |
| [aws_network_interface.eni-b](https://registry.terraform.io/providers/hashicorp/aws/3.59.0/docs/resources/network_interface) | resource |
| [aws_network_interface.eni-c](https://registry.terraform.io/providers/hashicorp/aws/3.59.0/docs/resources/network_interface) | resource |
| [aws_security_group.web-server-sg](https://registry.terraform.io/providers/hashicorp/aws/3.59.0/docs/resources/security_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_access_key"></a> [aws\_access\_key](#input\_aws\_access\_key) | AWS Access key | `any` | n/a | yes |
| <a name="input_aws_secret_key"></a> [aws\_secret\_key](#input\_aws\_secret\_key) | AWS secret key | `any` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
