variable "name" {
  type        = string
  description = "The name of the storage account"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the storage account"
}

variable "location" {
  type        = string
  description = "The location of the resource group in which to create the storage account"
}

variable "containers" {
  type        = list(string)
  default     = []
  description = "The list of containers to create in the storage account"
}

variable "account_replication_type" {
  type        = string
  description = "The replication type of the storage account"
  default     = "LRS"
}

resource "azurerm_storage_account" "this" {
  name                     = var.name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = var.account_replication_type
}

resource "azurerm_storage_container" "this" {
  count = length(var.containers)

  name                  = var.containers[count.index]
  storage_account_name  = azurerm_storage_account.this.name
  container_access_type = "private"
}
