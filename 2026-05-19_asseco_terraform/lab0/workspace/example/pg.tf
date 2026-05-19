resource "azurerm_postgresql_flexible_server" "postgres" {
  lifecycle {
    ignore_changes = [zone]
  }

  name                          = "${local.prefix}-pg"
  resource_group_name           = azurerm_resource_group.rg.name
  location                      = azurerm_resource_group.rg.location
  version                       = "16"
  delegated_subnet_id           = azurerm_subnet.db.id
  private_dns_zone_id           = azurerm_private_dns_zone.postgres.id
  administrator_login           = "pgadmin"
  administrator_password        = "ChangeMe123!"
  public_network_access_enabled = false
  storage_mb                    = 32768
  sku_name                      = "B_Standard_B1ms"

  authentication {
    active_directory_auth_enabled = true
    password_auth_enabled         = true
    tenant_id                     = data.azurerm_client_config.current.tenant_id
  }

  depends_on = [azurerm_private_dns_zone_virtual_network_link.postgres]
}

resource "azurerm_postgresql_flexible_server_active_directory_administrator" "entra_admin" {
  server_name         = azurerm_postgresql_flexible_server.postgres.name
  resource_group_name = azurerm_resource_group.rg.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  object_id           = data.azurerm_client_config.current.object_id
  principal_name      = data.azuread_user.current.user_principal_name
  principal_type      = "User"
}

resource "azurerm_postgresql_flexible_server_active_directory_administrator" "vm" {
  server_name         = azurerm_postgresql_flexible_server.postgres.name
  resource_group_name = azurerm_resource_group.rg.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  object_id           = azurerm_linux_virtual_machine.vm.identity[0].principal_id
  principal_name      = azurerm_linux_virtual_machine.vm.name
  principal_type      = "ServicePrincipal"
}

output "postgres_fqdn" {
  value = azurerm_postgresql_flexible_server.postgres.fqdn
}
