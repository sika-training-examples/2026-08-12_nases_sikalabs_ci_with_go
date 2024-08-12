resource "azurerm_virtual_network" "this" {
  name                = var.vnet.name
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = var.vnet.address_space
  tags                = var.vnet.tags
}

resource "azurerm_subnet" "this" {
  for_each = var.vnet.subnets

  name                 = each.key
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = each.value.address_prefixes

  dynamic "delegation" {
    for_each = each.value.service_delegation

    content {
      name = delegation.key

      service_delegation {
        actions = delegation.value.actions
        name    = delegation.value.name
      }
    }
  }
}
