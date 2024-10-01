resource "azurerm_resource_group" "this" {
  name     = "${var.name}-service-plan"
  location = var.location
}

resource "azurerm_service_plan" "this" {
  name                = var.name
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  os_type             = var.os_type
  sku_name            = var.sku_name
}
