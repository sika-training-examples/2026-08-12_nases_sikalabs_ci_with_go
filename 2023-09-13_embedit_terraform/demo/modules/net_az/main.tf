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
variable "resource_group_name" {
  type = string
}
variable "range" {}
variable "subnets" {}

locals {
  location = {
    EU = "westeurope"
    US = "useast"
  }[var.region]
}

resource "azurerm_virtual_network" "this" {
  name                = var.name
  address_space       = [var.range]
  location            = local.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "this" {
  count = length(var.subnets)

  name                 = "${var.name}${count.index}"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = [var.subnets[count.index]]
}

output "subnet_ids" {
  value = azurerm_subnet.this.*.id
}
