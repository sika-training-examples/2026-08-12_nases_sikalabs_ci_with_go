resource "azurerm_virtual_network" "training" {
  name                = "${azurerm_resource_group.training.name}-net"
  location            = azurerm_resource_group.training.location
  resource_group_name = azurerm_resource_group.training.name
  address_space       = ["10.10.0.0/16"]
}

resource "azurerm_subnet" "training-db" {
  name                 = "db"
  resource_group_name  = azurerm_resource_group.training.name
  virtual_network_name = azurerm_virtual_network.training.name
  address_prefixes     = ["10.10.0.0/24"]
  service_endpoints    = ["Microsoft.Storage"]
  delegation {
    name = "fs"
    service_delegation {
      name = "Microsoft.DBforPostgreSQL/flexibleServers"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }
}
