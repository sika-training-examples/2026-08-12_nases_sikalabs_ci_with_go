variable "config" {
  description = "Details of the storage accounts and their containers"
  type = object({
    # name: The name of storage account.
    name = string
    # resource_group_name: name of resource group.
    resource_group_name      = string
    location                 = string
    account_replication_type = optional(string, "LRS")
    containers               = optional(list(string))
  })
}

resource "azurerm_storage_account" "this" {
  name                     = var.config.name
  resource_group_name      = var.config.resource_group_name
  location                 = var.config.location
  account_tier             = "Standard"
  account_replication_type = var.config.account_replication_type
}

resource "azurerm_storage_container" "this" {
  count = length(var.config.containers)

  name                  = var.config.containers[count.index]
  storage_account_name  = azurerm_storage_account.this.name
  container_access_type = "private"
}
