terraform {
  backend "http" {
    address        = "https://gitlab.sikademo.com/api/v4/projects/11/terraform/state/default"
    lock_address   = "https://gitlab.sikademo.com/api/v4/projects/11/terraform/state/default/lock"
    unlock_address = "https://gitlab.sikademo.com/api/v4/projects/11/terraform/state/default/lock"
    username       = "token"
    lock_method    = "POST"
    unlock_method  = "DELETE"
    retry_wait_min = "5"

  }
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }
}

variable "azurerm_tenant_id" {}
variable "azurerm_subscription_id" {}
variable "azurerm_client_id" {}
variable "azurerm_client_secret" {}

provider "azurerm" {
  features {}
  tenant_id       = var.azurerm_tenant_id
  subscription_id = var.azurerm_subscription_id
  client_id       = var.azurerm_client_id
  client_secret   = var.azurerm_client_secret
}
