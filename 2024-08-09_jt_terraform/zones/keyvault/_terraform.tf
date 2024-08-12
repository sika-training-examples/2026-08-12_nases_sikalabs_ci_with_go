terraform {
  # backend "azurerm" {
  #   resource_group_name   = "terraform-state"
  #   storage_account_name  = "terraformstate2021"
  #   container_name        = "tfstate"
  #   key                   = "core.tfstate"
  # }
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
