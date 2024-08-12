locals {
  dns_forwarding_ruleset_id = "/subscriptions/12345678-1234-9876-4563-123456789012/resourceGroups/example-resource-group/providers/Microsoft.Network/dnsForwardingRulesets/dnsForwardingRulesetValue"
}

resource "azurerm_private_dns_resolver_forwarding_rule" "aaa" {
  name                      = "aaa"
  dns_forwarding_ruleset_id = local.dns_forwarding_ruleset_id
  domain_name               = "aaa.com"
  enabled                   = true

  target_dns_servers {
    ip_address = "1.1.1.1"
    port       = 53
  }

  target_dns_servers {
    ip_address = "2.2.2.2"
    port       = 53
  }
}

locals {
  target_dns_servers = {
    1 = {
      ip_address = "3.3.3.3"
      port       = 53
    },
    2 = {
      ip_address = "4.4.4.4"
      port       = 53
    }
  }
}

resource "azurerm_private_dns_resolver_forwarding_rule" "bbb" {
  name                      = "bbb"
  dns_forwarding_ruleset_id = local.dns_forwarding_ruleset_id
  domain_name               = "bbb.com"
  enabled                   = true

  dynamic "target_dns_servers" {
    for_each = local.target_dns_servers
    content {
      ip_address = target_dns_servers.value.ip_address
      port       = target_dns_servers.value.port
    }
  }
}
