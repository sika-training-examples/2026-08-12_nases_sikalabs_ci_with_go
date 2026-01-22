resource "azurerm_subnet" "this" {
  for_each = var.subnets

  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name

  name             = each.value.name
  address_prefixes = each.value.address_prefixes
}
