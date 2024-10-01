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
| [azurerm_kubernetes_cluster.this](https://registry.terraform.io/providers/hashicorp/azurerm/4.3.0/docs/resources/kubernetes_cluster) | resource |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/4.3.0/docs/resources/resource_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | The Kubernetes version of the AKS cluster | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The location of the AKS cluster | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the AKS cluster | `string` | n/a | yes |
| <a name="input_node_count"></a> [node\_count](#input\_node\_count) | The number of nodes in the AKS cluster | `number` | n/a | yes |
| <a name="input_tags_common"></a> [tags\_common](#input\_tags\_common) | n/a | `map(string)` | n/a | yes |
| <a name="input_vm_size"></a> [vm\_size](#input\_vm\_size) | The VM size of the AKS cluster | `string` | n/a | yes |

## Outputs

No outputs.
