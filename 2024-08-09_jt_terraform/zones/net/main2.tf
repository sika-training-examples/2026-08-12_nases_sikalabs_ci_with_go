module "net_34" {
  source = "../../modules/net"

  for_each = {
    "3" = {}
    "4" = {}
  }

  config = {
    name       = "jt-${each.key}"
    net_prefix = "10.${each.key}.0.0/16"
    subnets = [
      "10.${each.key}.0.0/24",
      "10.${each.key}.1.0/24",
    ]
  }
}
