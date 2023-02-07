## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_cloudflare"></a> [cloudflare](#requirement\_cloudflare) | 4.0.0-rc1 |
| <a name="requirement_digitalocean"></a> [digitalocean](#requirement\_digitalocean) | 2.26.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vm--db"></a> [vm--db](#module\_vm--db) | ../../modules/vm | n/a |
| <a name="module_vms"></a> [vms](#module\_vms) | ../../modules/vm | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_db_count"></a> [db\_count](#input\_db\_count) | n/a | `number` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | n/a | yes |
| <a name="input_ssh_keys"></a> [ssh\_keys](#input\_ssh\_keys) | n/a | `list(string)` | n/a | yes |
| <a name="input_vms"></a> [vms](#input\_vms) | n/a | `map(any)` | n/a | yes |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ansible-hosts"></a> [ansible-hosts](#output\_ansible-hosts) | n/a |
| <a name="output_dbs"></a> [dbs](#output\_dbs) | n/a |
| <a name="output_vms"></a> [vms](#output\_vms) | n/a |
