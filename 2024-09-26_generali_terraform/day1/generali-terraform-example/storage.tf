module "foo_storage" {
  source = "git::https://github.com/sika-training-examples/2024-09-26-generali-terraform-modules-example.git//modules/storage"

  name     = "generaliexamplefoo"
  location = local.WESTEUROPE
  containers = {
    "foo" = {
      container_access_type = "private"
    }
  }
  tags_common = local.tags_common
}

module "bar_storage" {
  source = "git::https://github.com/sika-training-examples/2024-09-26-generali-terraform-modules-example.git//modules/storage"

  name        = "generaliexamplebar"
  location    = local.WESTEUROPE
  tags_common = local.tags_common
  containers = {
    "bar" = {
      container_access_type = "private"
    }
  }
}

module "baz_storage" {
  source = "git::https://github.com/sika-training-examples/2024-09-26-generali-terraform-modules-example.git//modules/storage?ref=storage-v1"

  name                = "generaliexamplebaz"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  tags_common         = local.tags_common
}
