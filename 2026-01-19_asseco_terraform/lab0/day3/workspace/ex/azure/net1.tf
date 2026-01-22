resource "azurerm_virtual_network" "net1" {
  lifecycle {
    ignore_changes = [
      tags["created_at"]
    ]
  }

  tags = merge(local.common_tags, {})

  resource_group_name = azurerm_resource_group.training.name
  location            = azurerm_resource_group.training.location

  name          = "${azurerm_resource_group.training.name}-net1"
  address_space = ["10.10.0.0/16"]
}

resource "azurerm_virtual_network_peering" "net1-to-net2" {
  resource_group_name = azurerm_resource_group.training.name
  name                = "${azurerm_resource_group.training.name}-peer-net1-to-net2"

  virtual_network_name      = azurerm_virtual_network.net1.name
  remote_virtual_network_id = azurerm_virtual_network.net2.id
}

resource "azurerm_subnet" "net1-default" {
  resource_group_name  = azurerm_resource_group.training.name
  virtual_network_name = azurerm_virtual_network.net1.name

  name             = "default"
  address_prefixes = ["10.10.0.0/24"]
}
