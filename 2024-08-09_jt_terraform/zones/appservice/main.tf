data "azurerm_key_vault" "kv" {
  name                = "osdemojtkv999"
  resource_group_name = "kv"
}

module "hello_jt_dev" {
  source = "../../modules/hello_jt"

  env          = "dev"
  key_vault_id = data.azurerm_key_vault.kv.id
}

module "hello_jt_test" {
  source = "../../modules/hello_jt"

  env          = "test"
  key_vault_id = data.azurerm_key_vault.kv.id
}


module "hello_jt_xxx" {
  source = "../../modules/hello_jt"

  env          = "xxx"
  key_vault_id = data.azurerm_key_vault.kv.id
}

///////////////////////////

module "rgs" {
  source = "../../modules/rg"

  for_each = toset(["stage", "prod"])

  name = each.key
}

module "hello_jt_stage" {
  source = "../../modules/hello_jt_v2"

  env                 = "stage"
  resource_group_name = module.rgs["stage"].name
  location            = module.rgs["stage"].location
}

module "hello_jt_prod" {
  source = "../../modules/hello_jt_v2"

  env                 = "prod"
  resource_group_name = module.rgs["prod"].name
  location            = module.rgs["prod"].location
}
