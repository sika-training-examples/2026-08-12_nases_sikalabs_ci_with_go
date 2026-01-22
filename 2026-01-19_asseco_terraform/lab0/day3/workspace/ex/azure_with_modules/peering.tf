module "peering" {
  source = "./modules/net_peering"

  resource_group_name = azurerm_resource_group.training.name

  name = local.prefix

  networks = {
    "01" = {
      name = module.foo_net.network_name
      id   = module.foo_net.network_id
    }
    "02" = {
      name = module.bar_net.network_name
      id   = module.bar_net.network_id
    }
  }
}
