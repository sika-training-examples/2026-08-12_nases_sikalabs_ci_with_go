resource "random_string" "suffix" {
  length  = 4
  lower   = false
  upper   = false
  special = false
}

resource "azurerm_storage_account" "terraform-states" {
  name                     = "assecoterraform${random_string.suffix.result}"
  resource_group_name      = azurerm_resource_group.asseco-terraform-states.name
  location                 = azurerm_resource_group.asseco-terraform-states.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}

resource "azurerm_storage_container" "terraform-states" {
  name                  = "terraform-states"
  storage_account_id    = azurerm_storage_account.terraform-states.id
  container_access_type = "private"
}

output "storage_account_name" {
  value = azurerm_storage_account.terraform-states.name
}

output "storage_container_name" {
  value = azurerm_storage_container.terraform-states.name
}
