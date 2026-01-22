resource "azurerm_private_dns_zone" "training" {
  name                = "${azurerm_resource_group.training.name}zone.postgres.database.azure.com"
  resource_group_name = azurerm_resource_group.training.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "training" {
  depends_on = [
    azurerm_subnet.training-db,
  ]

  name                  = azurerm_resource_group.training.name
  private_dns_zone_name = azurerm_private_dns_zone.training.name
  virtual_network_id    = azurerm_virtual_network.training.id
  resource_group_name   = azurerm_resource_group.training.name
}
