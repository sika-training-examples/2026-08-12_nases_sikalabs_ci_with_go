resource "azurerm_resource_group" "rg" {
  name     = "${local.prefix}-rg-db"
  location = "westeurope"
}
