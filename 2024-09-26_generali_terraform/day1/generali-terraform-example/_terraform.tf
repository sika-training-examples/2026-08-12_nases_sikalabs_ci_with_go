terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.3"
    }
  }
  backend "pg" {}
}

variable "subscription_id" {}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}
