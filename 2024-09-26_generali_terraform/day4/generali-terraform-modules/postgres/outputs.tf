output "host" {
  value = azurerm_postgresql_flexible_server.this.fqdn
}

output "username" {
  value = azurerm_postgresql_flexible_server.this.administrator_login
}

output "password" {
  value     = random_password.admin.result
  sensitive = true
}
