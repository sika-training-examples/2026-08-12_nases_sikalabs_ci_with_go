import {
  to = azurerm_virtual_network.net3
  id = "/subscriptions/200acaec-2d60-43ad-915a-e8f5352a4ba7/resourceGroups/ondrejsika/providers/Microsoft.Network/virtualNetworks/ondrejsika-net3"
}

resource "azurerm_virtual_network" "net3" {
  lifecycle {
    ignore_changes = [
      tags["created_at"]
    ]
  }

  tags = merge(local.common_tags, {})

  resource_group_name = azurerm_resource_group.training.name
  location            = azurerm_resource_group.training.location

  name          = "${azurerm_resource_group.training.name}-net3"
  address_space = ["10.30.0.0/16"]
}

import {
  to = azurerm_subnet.net3-default
  id = "/subscriptions/200acaec-2d60-43ad-915a-e8f5352a4ba7/resourceGroups/ondrejsika/providers/Microsoft.Network/virtualNetworks/ondrejsika-net3/subnets/default"
}

resource "azurerm_subnet" "net3-default" {
  resource_group_name  = azurerm_resource_group.training.name
  virtual_network_name = azurerm_virtual_network.net3.name

  name             = "default"
  address_prefixes = ["10.30.0.0/24"]
}
