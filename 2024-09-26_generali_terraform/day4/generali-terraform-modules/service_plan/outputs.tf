output "service_plan_id" {
  value = azurerm_service_plan.this.id
}

output "resource_group_name" {
  value = azurerm_resource_group.this.name
}

output "resource_group_location" {
  value = azurerm_resource_group.this.location
}
