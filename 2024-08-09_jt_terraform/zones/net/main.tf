module "net_1" {
  source = "../../modules/net"

  config = {
    name       = "jt-1"
    net_prefix = "10.1.0.0/16"
    subnets = [
      "10.1.0.0/24",
      "10.1.1.0/24",
    ]
  }
}

module "net_2" {
  source = "../../modules/net"

  config = {
    name       = "jt-2"
    net_prefix = "10.2.0.0/16"
    subnets = [
      "10.2.0.0/24",
      "10.2.1.0/24",
    ]
  }
}
