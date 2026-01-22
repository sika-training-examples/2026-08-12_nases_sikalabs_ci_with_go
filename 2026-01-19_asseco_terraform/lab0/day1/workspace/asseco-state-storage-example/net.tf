resource "azurerm_resource_group" "asseco-net" {
  lifecycle {
    ignore_changes = [
      tags["created_at"]
    ]
  }

  name     = "asseco-net"
  location = "westeurope"

  tags = {
    team       = "cz-cloud-praha"
    created_at = timestamp()
  }
}

resource "azurerm_virtual_network" "asseco-net" {
  lifecycle {
    ignore_changes = [
      tags["created_at"]
    ]
  }

  tags = {
    team       = "cz-cloud-brno"
    created_at = timestamp()
  }

  name                = azurerm_resource_group.asseco-net.name
  location            = azurerm_resource_group.asseco-net.location
  resource_group_name = azurerm_resource_group.asseco-net.name
  address_space       = ["10.20.0.0/16"]
}

resource "azurerm_subnet" "asseco-net-ondrej2" {
  name                 = "ondrej2"
  virtual_network_name = azurerm_virtual_network.asseco-net.name
  resource_group_name  = azurerm_resource_group.asseco-net.name
  address_prefixes     = ["10.20.2.0/24"]
}
