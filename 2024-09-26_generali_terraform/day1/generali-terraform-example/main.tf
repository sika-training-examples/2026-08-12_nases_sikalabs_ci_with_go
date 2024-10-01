locals {
  WESTEUROPE = "westeurope"
  tags_common = {
    environment = "training"
    client      = "generali"
    location    = local.WESTEUROPE
    created_at  = timestamp()
  }
}

module "pets" {
  source = "./pets"
}

output "pet_names" {
  value = module.pets.pet_names
}

data "azurerm_resource_group" "root" {
  name = "generali"
}

resource "azurerm_resource_group" "example" {
  lifecycle { ignore_changes = [tags, ] }

  name       = "generali-example"
  location   = local.WESTEUROPE
  tags       = local.tags_common
  managed_by = data.azurerm_resource_group.root.id
}

resource "azurerm_storage_account" "example" {
  lifecycle {
    ignore_changes = [
      tags,
    ]
  }
  name                     = "generaliexampletraining"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = local.tags_common
}

resource "azurerm_storage_container" "example" {
  name                  = "example"
  storage_account_name  = azurerm_storage_account.example.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "count" {
  count = 2

  name                  = "count${count.index}"
  storage_account_name  = azurerm_storage_account.example.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "for_each" {
  for_each = toset(["two", "three"])

  name                  = "for-each-${each.key}"
  storage_account_name  = azurerm_storage_account.example.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "for_each_2" {
  for_each = {
    foo = { private = true },
    bar = { private = false },
  }

  name                  = "for-each-2-${each.key}"
  storage_account_name  = azurerm_storage_account.example.name
  container_access_type = each.value.private ? "private" : "container"
}

resource "azurerm_storage_container" "terraform_states" {
  name                  = "terraform-states"
  storage_account_name  = azurerm_storage_account.example.name
  container_access_type = "private"
}

output "storage_account_name" {
  value = azurerm_storage_account.example.name
}

output "container_names" {
  value = concat([
    azurerm_storage_container.example.name,
    azurerm_storage_container.terraform_states.name,
    ],
    [
      for c in azurerm_storage_container.count :
      c.name
    ],
    [
      for c in azurerm_storage_container.for_each :
      c.name
    ],
    [
      for c in azurerm_storage_container.for_each_2 :
      c.name
    ],
  )
}

output "primary_access_key" {
  value     = azurerm_storage_account.example.primary_access_key
  sensitive = true
}
