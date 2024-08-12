locals {
  rg_prefix = "jt"
}

module "terraform_states" {
  source = "../../modules/terraform_states"

  rg_prefix = local.rg_prefix
  name      = "osdemojtterraformstates"
}

module "storages" {
  source = "../../modules/storage_v2"

  for_each = {
    "foo" = {
      containers = ["foo", "bar", "baz"]
    }
    "bar" = {
      containers = ["aaa"]
    }
  }

  config = {
    name                = "osdemo435435${each.key}"
    resource_group_name = "jt-osdemojtterraformstates"
    location            = "westeurope"
    containers          = each.value.containers
  }
}

module "storage_foo" {
  source = "../../modules/storage_v2"

  config = {
    name                = "osdemo435435foox"
    resource_group_name = "jt-osdemojtterraformstates"
    location            = "westeurope"
    containers          = ["foo", "bar", "baz"]
  }
}

module "storage_bar" {
  source = "../../modules/storage_v2"

  config = {
    name                = "osdemo435435barx"
    resource_group_name = "jt-osdemojtterraformstates"
    location            = "westeurope"
    containers          = ["aaa"]
  }
}
