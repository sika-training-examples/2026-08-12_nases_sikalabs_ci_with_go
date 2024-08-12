locals {
  networks = {
    "jt-5" = {
      net_prefix = "10.5.0.0/16"
      subnets = [
        "10.5.0.0/24",
        "10.5.1.0/24",
      ]
    }
    "jt-6" = {
      net_prefix = "10.6.0.0/16"
      subnets = [
        "10.6.0.0/24",
        "10.6.1.0/24",
      ]
    }
  }
}

module "net_56" {
  source = "../../modules/net"

  for_each = local.networks
  config = merge(each.value, {
    name = each.key
  })
}
