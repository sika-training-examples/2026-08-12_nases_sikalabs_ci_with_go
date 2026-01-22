resource "azurerm_virtual_network_peering" "this" {
  for_each = merge([
    for key1, val1 in var.networks :
    {
      for key2, val2 in var.networks :
      "${key1}-${key2}" => {
        source_name = val1.name
        target_id   = val2.id
      } if key1 != key2
    }
  ]...)

  resource_group_name = var.resource_group_name

  name = "${var.name}-peer-${each.key}"

  virtual_network_name      = each.value.source_name
  remote_virtual_network_id = each.value.target_id
}
