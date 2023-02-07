## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_cloudflare"></a> [cloudflare](#requirement\_cloudflare) | 4.0.0-rc1 |
| <a name="requirement_digitalocean"></a> [digitalocean](#requirement\_digitalocean) | 2.26.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_cloudflare"></a> [cloudflare](#provider\_cloudflare) | 4.0.0-rc1 |
| <a name="provider_digitalocean"></a> [digitalocean](#provider\_digitalocean) | 2.26.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [cloudflare_record.this](https://registry.terraform.io/providers/cloudflare/cloudflare/4.0.0-rc1/docs/resources/record) | resource |
| [digitalocean_droplet.this](https://registry.terraform.io/providers/digitalocean/digitalocean/2.26.0/docs/resources/droplet) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_image"></a> [image](#input\_image) | n/a | `string` | `"debian-11-x64"` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"fra1"` | no |
| <a name="input_size"></a> [size](#input\_size) | n/a | `string` | `"s-1vcpu-1gb"` | no |
| <a name="input_ssh_keys"></a> [ssh\_keys](#input\_ssh\_keys) | n/a | `list(string)` | n/a | yes |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_domain"></a> [domain](#output\_domain) | n/a |
| <a name="output_ip"></a> [ip](#output\_ip) | n/a |
| <a name="output_name"></a> [name](#output\_name) | n/a |
