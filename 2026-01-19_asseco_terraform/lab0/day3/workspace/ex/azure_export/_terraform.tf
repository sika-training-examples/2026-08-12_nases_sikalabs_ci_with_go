terraform {
  required_providers {
    azurerm = {
      source  = "azurerm"
      version = "4.47.0"
    }
  }
}
provider "azurerm" {
  features {}
  subscription_id = "200acaec-2d60-43ad-915a-e8f5352a4ba7"
}
