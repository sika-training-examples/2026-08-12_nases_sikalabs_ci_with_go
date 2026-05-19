resource "azurerm_resource_group" "rg" {
  name     = "rg-${local.prefix}-net"
  location = local.location
}
