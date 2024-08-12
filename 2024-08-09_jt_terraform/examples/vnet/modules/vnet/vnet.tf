variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "location" {
  description = "The location of the resources."
  type        = string
}

variable "vnet" {
  description = "Map of VNET configurations, including subnets."
  type = map(object({
    address_space = list(string)
    tags          = map(string)
    subnets = map(object({
      address_prefixes = list(string)
      service_delegation = optional(map(object({
        actions = list(string)
        name    = string
      })), {})
    }))
  }))
}

variable "route_tables" {
  description = "Map of route table configurations."
  type = map(object({
    enable_subnet_route_table_association = bool
    disable_bgp_route_propagation         = bool
    subnet_ids                            = list(string)
    route_entries = map(object({
      address_prefix         = string
      next_hop_type          = string
      next_hop_in_ip_address = optional(string)
    }))
    tags = map(string)
  }))
  default = {}
}

variable "vnet_peering" {
  description = "Map of peering configurations."
  type = map(object({
    virtual_network_name         = string
    remote_virtual_network_id    = string
    allow_forwarded_traffic      = optional(bool, false)
    allow_gateway_transit        = optional(bool, false)
    allow_virtual_network_access = optional(bool, true)
    use_remote_gateways          = optional(bool, false)
  }))

  default = {}
}

resource "azurerm_virtual_network" "this" {
  name                = each.key
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = each.value.address_space
  tags                = each.value.tags
}

resource "azurerm_subnet" "this" {
  for_each = local.subnet_details

  name                 = each.key
  resource_group_name  = each.value.resource_group_name
  virtual_network_name = each.value.virtual_network_name
  address_prefixes     = each.value.address_prefixes

  dynamic "delegation" {
    for_each = each.value.service_delegation

    content {
      name = delegation.key

      service_delegation {
        actions = delegation.value.actions
        name    = delegation.value.name
      }
    }
  }

  depends_on = [azurerm_virtual_network.this]
}
