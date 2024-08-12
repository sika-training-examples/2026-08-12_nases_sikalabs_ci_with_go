resource "azurerm_private_dns_resolver" "this" {
  name                = var.dns_resolver.name
  resource_group_name = var.dns_resolver.resource_group_name
  location            = var.dns_resolver.location
  virtual_network_id  = var.dns_resolver.virtual_network_id
}

resource "azurerm_private_dns_resolver_inbound_endpoint" "this" {
  name                    = "${azurerm_private_dns_resolver.this.name}-inbound"
  private_dns_resolver_id = azurerm_private_dns_resolver.this.id
  location                = var.dns_resolver.location
  ip_configurations {
    private_ip_allocation_method = "Dynamic"
    subnet_id                    = var.dns_resolver.inbound_subnet_id
  }
  tags = var.dns_resolver.tags
}

resource "azurerm_private_dns_resolver_outbound_endpoint" "this" {
  name                    = "${azurerm_private_dns_resolver.this.name}-outbound"
  private_dns_resolver_id = azurerm_private_dns_resolver.this.id
  location                = var.dns_resolver.location
  subnet_id               = var.dns_resolver.outbound_subnet_id
  tags                    = var.dns_resolver.tags
  lifecycle {
    replace_triggered_by = [azurerm_private_dns_resolver.this]
  }

}

resource "azurerm_private_dns_resolver_dns_forwarding_ruleset" "this" {
  name                                       = var.dns_resolver.dns_forwarding_ruleset_name
  resource_group_name                        = var.dns_resolver.resource_group_name
  location                                   = var.dns_resolver.location
  private_dns_resolver_outbound_endpoint_ids = [azurerm_private_dns_resolver_outbound_endpoint.this.id]
  tags                                       = var.dns_resolver.tags

  lifecycle {
    replace_triggered_by = [azurerm_private_dns_resolver_outbound_endpoint.this]
  }
}

resource "azurerm_private_dns_resolver_forwarding_rule" "this" {
  for_each = var.dns_resolver.dns_forwarding_rules

  name                      = each.key
  dns_forwarding_ruleset_id = azurerm_private_dns_resolver_dns_forwarding_ruleset.this.id
  domain_name               = each.value.domain_name
  enabled                   = each.value.enabled

  dynamic "target_dns_servers" {
    for_each = each.value.target_dns_servers
    content {
      ip_address = target_dns_servers.value.ip_address
      port       = target_dns_servers.value.port
    }
  }

  metadata = each.value.metadata

  lifecycle {
    replace_triggered_by = [azurerm_private_dns_resolver_dns_forwarding_ruleset.this]
  }
}
