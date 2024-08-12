# locals {
#   containers_map = merge([
#     for sa_name, details in var.blob_storage : {
#       for container in details.containers :
#       "${sa_name}-${container.name}" => {
#         storage_account_name  = sa_name,
#         name                  = container.name,
#         container_access_type = container.container_access_type
#       }
#     }
#   ]...)
# }


resource "azurerm_storage_container" "this" {
  for_each = var.containers

  name                  = each.name
  storage_account_name  = azurerm_storage_account.this.name
  container_access_type = each.value.container_access_type
}
