terraform {
  backend "http" {}
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.3.0"
    }
  }
}

variable "client_id" {}
variable "client_secret" {}

provider "azurerm" {
  features {}

  tenant_id       = "f2d0a0f9-bb6c-4645-80d0-0481dcc90588"
  subscription_id = "200acaec-2d60-43ad-915a-e8f5352a4ba7"
  client_id       = var.client_id
  client_secret   = var.client_secret
}
