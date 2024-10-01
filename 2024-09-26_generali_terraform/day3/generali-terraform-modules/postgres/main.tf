resource "azurerm_resource_group" "this" {
  name     = "${var.name}-postgres"
  location = var.location
}


resource "random_password" "admin" {
  length           = 16
  special          = true
  override_special = "_"
}

resource "azurerm_postgresql_flexible_server" "this" {
  lifecycle {
    ignore_changes = [
      zone,
    ]
  }

  name                = var.name
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  administrator_login    = "postgres_admin"
  administrator_password = random_password.admin.result

  sku_name   = var.sku_name
  version    = var.postgres_version
  storage_mb = var.storage_mb

  backup_retention_days        = var.backup_retention_days
  geo_redundant_backup_enabled = true
  auto_grow_enabled            = true

  public_network_access_enabled = var.public_network_access_enabled
}

resource "azurerm_postgresql_flexible_server_firewall_rule" "this" {
  for_each = var.firewall_rules

  name             = each.key
  server_id        = azurerm_postgresql_flexible_server.this.id
  start_ip_address = each.value.start_ip_address
  end_ip_address   = each.value.end_ip_address
}

resource "azurerm_postgresql_flexible_server_database" "this" {
  for_each = toset(var.databases)

  name      = each.key
  server_id = azurerm_postgresql_flexible_server.this.id
  collation = "en_US.utf8"
  charset   = "utf8"
}
