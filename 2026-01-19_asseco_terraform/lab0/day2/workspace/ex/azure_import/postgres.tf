import {
  to = azurerm_postgresql_flexible_server.manual-postgres-server
  id = "/subscriptions/200acaec-2d60-43ad-915a-e8f5352a4ba7/resourceGroups/manual-postgres/providers/Microsoft.DBforPostgreSQL/flexibleServers/manual-postgres-server"
}

resource "azurerm_postgresql_flexible_server" "manual-postgres-server" {
  administrator_login           = "azadmin"
  administrator_password        = "jHDr_L36R_4PaE_451B"
  auto_grow_enabled             = false
  backup_retention_days         = 14
  delegated_subnet_id           = "/subscriptions/200acaec-2d60-43ad-915a-e8f5352a4ba7/resourceGroups/ondrejsika/providers/Microsoft.Network/virtualNetworks/ondrejsika-net/subnets/db"
  geo_redundant_backup_enabled  = false
  location                      = "westeurope"
  name                          = "manual-postgres-server"
  private_dns_zone_id           = "/subscriptions/200acaec-2d60-43ad-915a-e8f5352a4ba7/resourceGroups/ondrejsika/providers/Microsoft.Network/privateDnsZones/ondrejsikazone.postgres.database.azure.com"
  public_network_access_enabled = false
  resource_group_name           = azurerm_resource_group.manual-postgres.name
  sku_name                      = "GP_Standard_D2ds_v5"
  storage_mb                    = 32768
  storage_tier                  = "P4"
  tags                          = {}
  version                       = "17"
  zone                          = "2"
  authentication {
    active_directory_auth_enabled = true
    password_auth_enabled         = true
    tenant_id                     = "f2d0a0f9-bb6c-4645-80d0-0481dcc90588"
  }
}

import {
  to = azurerm_postgresql_flexible_server_active_directory_administrator.manual-postgres-server-ondrejsika
  id = "/subscriptions/200acaec-2d60-43ad-915a-e8f5352a4ba7/resourceGroups/manual-postgres/providers/Microsoft.DBforPostgreSQL/flexibleServers/manual-postgres-server/administrators/0fdd1722-661a-4b94-9292-192544017b60"
}

resource "azurerm_postgresql_flexible_server_active_directory_administrator" "manual-postgres-server-ondrejsika" {
  object_id           = "0fdd1722-661a-4b94-9292-192544017b60"
  principal_name      = "ondrej@sika.io"
  principal_type      = "User"
  resource_group_name = azurerm_resource_group.manual-postgres.name
  server_name         = "manual-postgres-server"
  tenant_id           = "f2d0a0f9-bb6c-4645-80d0-0481dcc90588"
  depends_on = [
    azurerm_postgresql_flexible_server.manual-postgres-server,
  ]
}

resource "azurerm_postgresql_flexible_server_database" "manual-postgres-server-my-db" {
  charset   = "UTF8"
  collation = "en_US.utf8"
  name      = "my-db"
  server_id = azurerm_postgresql_flexible_server.manual-postgres-server.id
}
