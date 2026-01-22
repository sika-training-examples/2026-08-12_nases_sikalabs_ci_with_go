resource "azurerm_public_ip" "ip-1" {
  lifecycle {
    ignore_changes = [
      tags["created_at"]
    ]
  }

  tags = merge(local.common_tags, {
    used_for = "vm"
  })

  name                = "${azurerm_resource_group.training.name}-1"
  resource_group_name = azurerm_resource_group.training.name
  location            = azurerm_resource_group.training.location
  allocation_method   = "Static"
}

resource "azurerm_public_ip" "ip-2" {
  lifecycle {
    ignore_changes = [
      tags["created_at"]
    ]
  }

  tags = merge(local.common_tags, {
    used_for = "vm"
  })

  name                = "${azurerm_resource_group.training.name}-2"
  resource_group_name = azurerm_resource_group.training.name
  location            = azurerm_resource_group.training.location
  allocation_method   = "Static"
}
