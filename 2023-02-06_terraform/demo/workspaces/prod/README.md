## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_cloudflare"></a> [cloudflare](#requirement\_cloudflare) | 4.0.0-rc1 |
| <a name="requirement_digitalocean"></a> [digitalocean](#requirement\_digitalocean) | 2.26.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_digitalocean"></a> [digitalocean](#provider\_digitalocean) | 2.26.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_example"></a> [example](#module\_example) | ../../applications/example | n/a |

## Resources

| Name | Type |
|------|------|
| [digitalocean_ssh_key.default](https://registry.terraform.io/providers/digitalocean/digitalocean/2.26.0/docs/data-sources/ssh_key) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloudflare_api_token"></a> [cloudflare\_api\_token](#input\_cloudflare\_api\_token) | n/a | `string` | n/a | yes |
| <a name="input_digitalocean_token"></a> [digitalocean\_token](#input\_digitalocean\_token) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_example"></a> [example](#output\_example) | n/a |
| <a name="output_example-ansible-hosts"></a> [example-ansible-hosts](#output\_example-ansible-hosts) | n/a |
