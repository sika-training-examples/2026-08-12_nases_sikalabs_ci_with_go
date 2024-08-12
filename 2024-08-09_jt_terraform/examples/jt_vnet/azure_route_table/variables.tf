variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "location" {
  description = "The location of the resources."
  type        = string
}

variable "route_table" {
  description = "Route table configurations."
  type = object({
    name                                  = string
    enable_subnet_route_table_association = bool
    disable_bgp_route_propagation         = bool
    subnet_ids                            = list(string)
    route_entries = map(object({
      address_prefix         = string
      next_hop_type          = string
      next_hop_in_ip_address = optional(string)
    }))
    tags = optional(map(string), {})
  })
}
