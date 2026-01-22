resource "azurerm_virtual_network" "this" {
  lifecycle {
    ignore_changes = [
      tags["created_at"]
    ]
  }

  tags = var.tags

  resource_group_name = var.resource_group_name
  location            = var.location

  name          = var.name
  address_space = var.address_space
}
