module "bar_net" {
  source = "./modules/net"

  resource_group_name = azurerm_resource_group.training.name
  location            = azurerm_resource_group.training.location
  tags                = local.common_tags

  name          = "${local.prefix}-bar-net"
  address_space = ["10.20.0.0/16"]
  subnets = {
    "01" = {
      name             = "default"
      address_prefixes = ["10.20.10.0/24"]
    }
    "02" = {
      name             = "db"
      address_prefixes = ["10.20.110.0/24"]
    }
  }
}
