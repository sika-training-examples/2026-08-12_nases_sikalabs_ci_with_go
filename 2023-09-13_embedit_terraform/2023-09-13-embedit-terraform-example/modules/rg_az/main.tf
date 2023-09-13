terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }
}

variable "name" {
  type = string
}
variable "region" {
  type = string
}

locals {
  location = {
    EU = "westeurope"
    US = "useast"
  }[var.region]
}

resource "azurerm_resource_group" "this" {
  name     = var.name
  location = local.location
}

output "name" {
  value = var.name
}
