resource "azurerm_virtual_network" "manual" {
  address_space                  = ["10.0.0.0/16"]
  location                       = "westeurope"
  name                           = "x-manual"
  private_endpoint_vnet_policies = "Disabled"
  resource_group_name            = azurerm_resource_group.manual.name
}

resource "azurerm_subnet" "manual-default" {
  address_prefixes     = ["10.0.0.0/24"]
  name                 = "default"
  resource_group_name  = azurerm_resource_group.manual.name
  virtual_network_name = azurerm_virtual_network.manual.name
}

resource "azurerm_subnet" "manual-foo" {
  address_prefixes     = ["10.0.1.0/24"]
  name                 = "foo"
  resource_group_name  = azurerm_resource_group.manual.name
  virtual_network_name = azurerm_virtual_network.manual.name
}
