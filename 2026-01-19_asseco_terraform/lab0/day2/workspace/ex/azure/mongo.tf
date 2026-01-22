resource "azurerm_resource_group" "mongo" {
  name     = "${azurerm_resource_group.training.name}-mongo"
  location = "East US"
}

resource "azurerm_mongo_cluster" "mongo" {
  administrator_password = "wPB3_pWgC_j3Pm_3bzz"
  administrator_username = "azadmin"
  compute_tier           = "M10"
  high_availability_mode = "Disabled"
  location               = "westeurope"
  name                   = "${azurerm_resource_group.training.name}-mongo"
  public_network_access  = "Enabled"
  resource_group_name    = azurerm_resource_group.mongo.name
  shard_count            = 1
  storage_size_in_gb     = 128
  tags                   = {}
  version                = "8.0"
}

resource "azurerm_mongo_cluster_firewall_rule" "mongo-allow-all" {
  name             = "all"
  mongo_cluster_id = azurerm_mongo_cluster.mongo.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "255.255.255.255"
}

output "mongo_connection_string" {
  value     = azurerm_mongo_cluster.mongo.connection_strings[0].value
  sensitive = true
}
