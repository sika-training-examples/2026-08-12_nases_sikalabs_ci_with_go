resource "random_password" "postgres-training" {
  length           = 16
  special          = true
  override_special = "_"
}

resource "azurerm_postgresql_flexible_server" "training" {
  lifecycle {
    ignore_changes = [
      zone,
    ]
  }

  depends_on = [
    azurerm_private_dns_zone_virtual_network_link.training,
  ]

  name                          = azurerm_resource_group.training.name
  resource_group_name           = azurerm_resource_group.training.name
  location                      = azurerm_resource_group.training.location
  version                       = "17"
  delegated_subnet_id           = azurerm_subnet.training-db.id
  private_dns_zone_id           = azurerm_private_dns_zone.training.id
  public_network_access_enabled = false
  administrator_login           = "psqladmin"
  administrator_password        = random_password.postgres-training.result
  sku_name                      = "B_Standard_B1ms"

  storage_mb   = 32768
  storage_tier = "P4"
}

output "postgress_password" {
  value     = random_password.postgres-training.result
  sensitive = true
}
