resource "azurerm_virtual_network" "manual2" {
  address_space       = ["11.0.0.0/16"]
  location            = "westeurope"
  name                = "x-manual2"
  resource_group_name = azurerm_resource_group.manual.name
}

resource "azurerm_subnet" "manual2-default" {
  address_prefixes     = ["11.0.0.0/24"]
  name                 = "default"
  resource_group_name  = azurerm_resource_group.manual.name
  virtual_network_name = azurerm_virtual_network.manual2.name
}

resource "azurerm_subnet" "manual2-foo" {
  address_prefixes     = ["11.0.1.0/24"]
  name                 = "foo"
  resource_group_name  = azurerm_resource_group.manual.name
  virtual_network_name = azurerm_virtual_network.manual2.name
}


resource "azurerm_subnet" "manual2-bar" {
  address_prefixes     = ["11.0.2.0/24"]
  name                 = "bar"
  resource_group_name  = azurerm_resource_group.manual.name
  virtual_network_name = azurerm_virtual_network.manual2.name
}
