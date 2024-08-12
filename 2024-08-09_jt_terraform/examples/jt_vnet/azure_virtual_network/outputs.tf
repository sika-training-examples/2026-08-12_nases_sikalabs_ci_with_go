output "subnet_ids" {
  value = { for k, v in azurerm_subnet.this : k => v.id }
}

output "subnet_names" {
  value = { for k, v in azurerm_subnet.this : k => v.name }
}

output "subnet_address_prefixes" {
  value = { for k, v in azurerm_subnet.this : k => v.address_prefixes }
}

output "vnet_id" {
  value = azurerm_virtual_network.this.id
}

output "vnet_names" {
  value = azurerm_virtual_network.this.name
}
