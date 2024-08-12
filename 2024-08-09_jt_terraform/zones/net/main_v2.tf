module "net_1x" {
  source = "../../modules/net_v2"

  config = {
    "jt-1x" = {
      net_prefix = "10.1.0.0/16"
      subnets = [
        "10.1.0.0/24",
        "10.1.1.0/24",
      ]
    }
  }
}

module "net_2x" {
  source = "../../modules/net_v2"

  config = {
    "jt-2x" = {
      net_prefix = "10.2.0.0/16"
      subnets = [
        "10.2.0.0/24",
        "10.2.1.0/24",
      ]
    }
  }
}
