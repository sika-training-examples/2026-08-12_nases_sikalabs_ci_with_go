module "rg" {
  source = "../../modules/rg"

  name = "jt-rg"
}

module "dns_resolver" {
  source = "../../modules/dns_resolver"

  dns_resolver = {
    name                        = "jt-dns-resolver"
    resource_group_name         = module.rg.name
    location                    = module.rg.location
    virtual_network_id          = module.net_1.virtual_network_id
    inbound_subnet_id           = module.net_1.subnet_ids[0]
    outbound_subnet_id          = module.net_1.subnet_ids[1]
    dns_forwarding_ruleset_name = "jt-dns-forwarding-ruleset"
    dns_forwarding_rules = {
      "aaa" = {
        domain_name = "aaa.com"
        enabled     = true
        target_dns_servers = [
          {
            ip_address = "1.1.1.1"
            port       = 53
          },
          {
            ip_address = "8.8.8.8"
            port       = 53
          },
        ]
      },
    }
  }
}
