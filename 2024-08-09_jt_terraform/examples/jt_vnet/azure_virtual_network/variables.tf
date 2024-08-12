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
  type = object({
    name          = string
    address_space = list(string)
    tags          = map(string)
    subnets = map(object({
      address_prefixes = list(string)
      service_delegation = optional(map(object({
        actions = list(string)
        name    = string
      })), {})
    }))
  })
}

variable "vnet_peering" {
  description = "Map of peering configurations."
  type = map(object({
    remote_virtual_network_id    = string
    allow_forwarded_traffic      = optional(bool, false)
    allow_gateway_transit        = optional(bool, false)
    allow_virtual_network_access = optional(bool, true)
    use_remote_gateways          = optional(bool, false)
  }))
}
