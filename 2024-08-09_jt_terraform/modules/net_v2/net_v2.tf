variable "config" {
  type = map(object({
    location   = optional(string, "westeurope")
    net_prefix = string
    subnets    = list(string)
  }))
}

resource "azurerm_resource_group" "this" {
  for_each = var.config

  name     = "${each.key}-rg"
  location = each.value.location
}

resource "azurerm_virtual_network" "this" {
  for_each = var.config

  name                = "${each.key}-net"
  location            = azurerm_resource_group.this[each.key].location
  resource_group_name = azurerm_resource_group.this[each.key].name
  address_space       = [each.value.net_prefix]
}

resource "azurerm_subnet" "this" {
  for_each = merge([
    for name, val in var.config : {
      for i, subnet in val.subnets :
      "${name}-subnet-${i}" => merge(val, {
        name   = name
        subnet = subnet
        }
      )
    }
  ]...)

  name                 = each.key
  resource_group_name  = azurerm_resource_group.this[each.value.name].name
  virtual_network_name = azurerm_virtual_network.this[each.value.name].name
  address_prefixes     = [each.value.subnet]
}
