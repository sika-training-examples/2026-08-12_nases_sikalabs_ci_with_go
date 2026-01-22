resource "random_password" "postgres-copy-of-manual" {
  length           = 16
  special          = true
  override_special = "_"
}

resource "azurerm_postgresql_flexible_server" "copy-of-manual" {
  administrator_login           = "azadmin"
  administrator_password        = random_password.postgres-copy-of-manual.result
  auto_grow_enabled             = false
  backup_retention_days         = 7
  delegated_subnet_id           = azurerm_subnet.training-db.id
  geo_redundant_backup_enabled  = false
  location                      = azurerm_resource_group.training.location
  name                          = "${azurerm_resource_group.training.name}-copy-of-manual"
  private_dns_zone_id           = azurerm_private_dns_zone.training.id
  public_network_access_enabled = false
  resource_group_name           = azurerm_resource_group.training.name
  sku_name                      = "B_Standard_B1ms"
  storage_mb                    = 32768
  storage_tier                  = "P4"
  tags                          = {}
  version                       = "17"
  zone                          = "2"
}
