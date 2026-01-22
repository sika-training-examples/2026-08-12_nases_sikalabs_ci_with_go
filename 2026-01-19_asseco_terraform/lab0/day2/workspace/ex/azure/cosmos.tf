resource "random_integer" "ri" {
  min = 10000
  max = 99999
}

resource "azurerm_cosmosdb_account" "mongo" {
  name                = "${azurerm_resource_group.training.name}-cosmos-mongo-${random_integer.ri.result}"
  location            = azurerm_resource_group.training.location
  resource_group_name = azurerm_resource_group.training.name
  offer_type          = "Standard"
  kind                = "MongoDB"

  is_virtual_network_filter_enabled = false

  geo_location {
    location          = azurerm_resource_group.training.location
    failover_priority = 0
  }

  capabilities {
    name = "EnableAggregationPipeline"
  }

  capabilities {
    name = "mongoEnableDocLevelTTL"
  }

  capabilities {
    name = "MongoDBv3.4"
  }

  capabilities {
    name = "EnableMongo"
  }

  consistency_policy {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 300
    max_staleness_prefix    = 100000
  }
}

output "mongo_conn_string" {
  value     = azurerm_cosmosdb_account.mongo.primary_mongodb_connection_string
  sensitive = true
}

resource "azurerm_cosmosdb_mongo_database" "mongo-my-db" {
  resource_group_name = azurerm_resource_group.training.name
  account_name        = azurerm_cosmosdb_account.mongo.name
  name                = "my-db"
}

resource "azurerm_cosmosdb_mongo_collection" "pets" {
  resource_group_name = azurerm_resource_group.training.name
  account_name        = azurerm_cosmosdb_account.mongo.name
  database_name       = azurerm_cosmosdb_mongo_database.mongo-my-db.name
  name                = "pets"
  index {
    keys   = ["_id"]
    unique = true
  }
}
