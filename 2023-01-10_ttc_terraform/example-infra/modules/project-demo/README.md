## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_digitalocean"></a> [digitalocean](#provider\_digitalocean) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_db"></a> [db](#module\_db) | ../../modules/vm | n/a |
| <a name="module_vm"></a> [vm](#module\_vm) | ../../modules/vm | n/a |

## Resources

| Name | Type |
|------|------|
| [digitalocean_ssh_key.default](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/data-sources/ssh_key) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_config"></a> [config](#input\_config) | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ips"></a> [ips](#output\_ips) | n/a |
