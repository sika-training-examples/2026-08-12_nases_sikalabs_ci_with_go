variable "config" {
  type = object({
    name       = string
    location   = optional(string, "westeurope")
    net_prefix = string
    subnets    = list(string)
  })
}

resource "azurerm_resource_group" "this" {
  name     = "${var.config.name}-rg"
  location = var.config.location
}

resource "azurerm_virtual_network" "this" {
  name                = "${var.config.name}-net"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  address_space       = [var.config.net_prefix]
}

resource "azurerm_subnet" "this" {
  count = length(var.config.subnets)

  name                 = "${var.config.name}-subnet-${count.index}"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = [var.config.subnets[count.index]]
}

output "virtual_network_id" {
  value = azurerm_virtual_network.this.id
}

output "subnet_ids" {
  value = azurerm_subnet.this[*].id
}
