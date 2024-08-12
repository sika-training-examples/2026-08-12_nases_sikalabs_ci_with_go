resource "azurerm_route_table" "this" {
  name                = var.route_table.name
  location            = var.location
  resource_group_name = var.resource_group_name
  # disable_bgp_route_propagation = var.route_table.disable_bgp_route_propagation

  dynamic "route" {
    for_each = var.route_table.route_entries

    content {
      name                   = route.key
      address_prefix         = route.value.address_prefix
      next_hop_type          = route.value.next_hop_type
      next_hop_in_ip_address = route.value.next_hop_in_ip_address
    }
  }

  tags = var.route_table.tags
}

resource "azurerm_subnet_route_table_association" "this" {
  for_each = toset(var.route_table.subnet_ids)

  subnet_id      = each.key
  route_table_id = azurerm_route_table.this.id
}
