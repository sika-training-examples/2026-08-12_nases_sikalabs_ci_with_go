locals {
  random_suffix = true
}

resource "random_string" "random_suffix" {
  count = local.random_suffix ? 1 : 0

  length  = 6
  special = false
  upper   = false
}

locals {
  random_suffix_value = local.random_suffix ? random_string.random_suffix[0].result : ""
}


resource "azurerm_resource_group" "random_suffix" {
  name     = "randomsuffix${local.random_suffix_value}"
  location = local.WESTEUROPE
}

output "random_suffix_resource_group" {
  value = azurerm_resource_group.random_suffix.name
}
