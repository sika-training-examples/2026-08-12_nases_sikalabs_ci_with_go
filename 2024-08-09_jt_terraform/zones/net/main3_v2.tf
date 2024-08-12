locals {
  networks2 = {
    "jt-5x" = {
      net_prefix = "10.5.0.0/16"
      subnets = [
        "10.5.0.0/24",
        "10.5.1.0/24",
      ]
    }
    "jt-6x" = {
      net_prefix = "10.6.0.0/16"
      subnets = [
        "10.6.0.0/24",
        "10.6.1.0/24",
      ]
    }
  }
}

module "net_56v2" {
  source = "../../modules/net_v2"

  config = local.networks2
}
