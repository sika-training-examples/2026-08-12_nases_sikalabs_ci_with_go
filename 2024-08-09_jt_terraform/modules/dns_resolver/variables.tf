variable "dns_resolver" {
  description = "Configuration for DNS resolvers across multiple virtual networks"
  type = object({
    name                        = string
    resource_group_name         = string
    location                    = string
    virtual_network_id          = string
    inbound_subnet_id           = string
    outbound_subnet_id          = string
    tags                        = optional(map(string), {})
    dns_forwarding_ruleset_name = string
    dns_forwarding_rules = map(object({
      domain_name = string
      enabled     = bool
      target_dns_servers = list(object({
        ip_address = string
        port       = number
      }))
      metadata = optional(map(string), {})
    }))
  })
}
