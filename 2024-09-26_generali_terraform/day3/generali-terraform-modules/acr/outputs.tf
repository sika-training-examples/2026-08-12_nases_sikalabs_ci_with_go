output "id" {
  value = azurerm_container_registry.this.id
}

output "domain" {
  value = azurerm_container_registry.this.login_server
}
