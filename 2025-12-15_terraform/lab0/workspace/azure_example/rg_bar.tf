resource "azurerm_resource_group" "bar" {
  for_each = {
    "b" = { aaa = "bbb" }
    "c" = {}
    "d" = { ddd = "ddd" }
  }

  lifecycle {
    ignore_changes = [tags["created"]]
  }

  name     = "${local.prefix}-bar-${each.key}"
  location = local.LOCATION
  tags = merge({
    environment = local.ENVIRONMENT
    created     = timestamp()
  }, each.value)
}

output "bar_object" {
  value = {
    for _, rg in azurerm_resource_group.bar :
    rg.name => rg.tags
  }
}
