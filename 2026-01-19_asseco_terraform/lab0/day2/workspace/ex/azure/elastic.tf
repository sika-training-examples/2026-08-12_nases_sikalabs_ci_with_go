resource "azurerm_elastic_cloud_elasticsearch" "training" {
  name                        = azurerm_resource_group.training.name
  resource_group_name         = azurerm_resource_group.training.name
  location                    = azurerm_resource_group.training.location
  sku_name                    = "ess-consumption-2024_Monthly"
  elastic_cloud_email_address = "ondrejsikatest@gmail.com"
  monitoring_enabled          = false
}
