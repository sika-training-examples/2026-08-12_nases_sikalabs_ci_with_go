resource "azurerm_resource_group" "foo" {
  count = 2

  lifecycle {
    ignore_changes = [tags["created"]]
  }

  name     = "${local.prefix}-foo-${count.index}"
  location = local.LOCATION
  tags = {
    environment = local.ENVIRONMENT
    created     = timestamp()
  }
}

output "foo_list" {
  value = [
    for rg in azurerm_resource_group.foo :
    {
      name = rg.name
      tags = rg.tags
    }
  ]
}

output "foo_object" {
  value = {
    for rg in azurerm_resource_group.foo :
    rg.name => rg.tags
  }
}
