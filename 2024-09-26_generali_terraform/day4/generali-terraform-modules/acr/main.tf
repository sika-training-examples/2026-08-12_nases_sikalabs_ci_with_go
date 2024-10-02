resource "azurerm_resource_group" "this" {
  name     = "${var.name}-acr"
  location = var.location
}

resource "azurerm_container_registry" "this" {
  name                = var.name
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  sku                 = "Basic"
}
