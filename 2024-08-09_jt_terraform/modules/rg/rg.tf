variable "name" {
  type        = string
  description = "The name of the resource group"
}

variable "location" {
  type        = string
  description = "The location of the resource group"
  default     = "westeurope"
}

resource "azurerm_resource_group" "this" {
  name     = "jtfg-${var.name}"
  location = var.location
}

output "name" {
  value = azurerm_resource_group.this.name
}

output "location" {
  value = azurerm_resource_group.this.location
}
