terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "b5d88a63-e32d-4458-a045-f04c2f7782f3"
}

data "azurerm_client_config" "current" {}

data "azuread_user" "current" {
  object_id = data.azurerm_client_config.current.object_id
}
