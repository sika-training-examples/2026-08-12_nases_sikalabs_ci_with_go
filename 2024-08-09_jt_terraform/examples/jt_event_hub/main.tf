terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "event_hub_rg"
  location = "East US"

}

module "my_event_hub_namespace" {
  source = "./event_hub_namespace"

  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  event_hub_namespace = {
    name                          = "eventhubnstestjt"
    sku                           = "Standard"
    capacity                      = 5
    tags                          = { environment = "dev" }
    public_network_access_enabled = true
    event_hubs = {
      "a" = {
        partition_count   = 1
        message_retention = 1
      }
      "b" = {
        partition_count   = 1
        message_retention = 1
      }
    }
  }
}

output "eventhub_ids" {
  value = module.my_event_hub_namespace.eventhub_ids
}
