output "postgres_fqdn" {
  value = azurerm_postgresql_flexible_server.postgres.fqdn
}

output "current_user_upn" {
  value = data.azuread_user.current.user_principal_name
}
