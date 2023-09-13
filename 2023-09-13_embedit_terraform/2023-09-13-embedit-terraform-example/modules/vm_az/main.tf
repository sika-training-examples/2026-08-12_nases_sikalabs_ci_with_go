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
variable "image" {
  type = string
}
# az specific
variable "subnet_id" {
  type = string
}
variable "resource_group_name" {
  type = string
}


locals {
  location = {
    EU = "westeurope"
    US = "useast"
  }[var.region]
  image_publisher = {
    UBUNTU = "Canonical"
  }[var.image]
  image_offer = {
    UBUNTU = "0001-com-ubuntu-server-focal"
  }[var.image]
  image_sku = {
    UBUNTU = "20_04-lts"
  }[var.image]
  image_version = {
    UBUNTU = "latest"
  }[var.image]
}

resource "azurerm_public_ip" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = local.location
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "this" {
  name                = var.name
  location            = local.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.this.id
  }
}

resource "azurerm_linux_virtual_machine" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = local.location
  size                = "Standard_B1ls"
  admin_username      = "azadmin"
  admin_ssh_key {
    username   = "azadmin"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCslNKgLyoOrGDerz9pA4a4Mc+EquVzX52AkJZz+ecFCYZ4XQjcg2BK1P9xYfWzzl33fHow6pV/C6QC3Fgjw7txUeH7iQ5FjRVIlxiltfYJH4RvvtXcjqjk8uVDhEcw7bINVKVIS856Qn9jPwnHIhJtRJe9emE7YsJRmNSOtggYk/MaV2Ayx+9mcYnA/9SBy45FPHjMlxntoOkKqBThWE7Tjym44UNf44G8fd+kmNYzGw9T5IKpH1E1wMR+32QJBobX6d7k39jJe8lgHdsUYMbeJOFPKgbWlnx9VbkZh+seMSjhroTgniHjUl8wBFgw0YnhJ/90MgJJL4BToxu9PVnH"
  }
  network_interface_ids = [
    azurerm_network_interface.this.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = local.image_publisher
    offer     = local.image_offer
    sku       = local.image_sku
    version   = local.image_version
  }
}

output "ip" {
  value = azurerm_public_ip.this.ip_address
}
