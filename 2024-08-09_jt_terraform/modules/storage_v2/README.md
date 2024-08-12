## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~>3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~>3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_storage_account.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_container.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_config"></a> [config](#input\_config) | Details of the storage accounts and their containers | <pre>object({<br>    # name: The name of storage account.<br>    name = string<br>    # resource_group_name: name of resource group.<br>    resource_group_name      = string<br>    location                 = string<br>    account_replication_type = optional(string, "LRS")<br>    containers               = optional(list(string))<br>  })</pre> | n/a | yes |

## Outputs

No outputs.
