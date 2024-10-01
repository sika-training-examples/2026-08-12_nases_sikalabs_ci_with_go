## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 4.3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 4.3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/4.3.0/docs/resources/resource_group) | resource |
| [azurerm_storage_account.this](https://registry.terraform.io/providers/hashicorp/azurerm/4.3.0/docs/resources/storage_account) | resource |
| [azurerm_storage_container.this](https://registry.terraform.io/providers/hashicorp/azurerm/4.3.0/docs/resources/storage_container) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_containers"></a> [containers](#input\_containers) | The containers to create in the storage account | <pre>map(object({<br>    container_access_type = string<br>  }))</pre> | `{}` | no |
| <a name="input_location"></a> [location](#input\_location) | The location of the storage account | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the storage account | `string` | n/a | yes |
| <a name="input_tags_common"></a> [tags\_common](#input\_tags\_common) | n/a | `map(string)` | n/a | yes |

## Outputs

No outputs.
