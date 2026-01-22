module "bar_vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.6.0"

  azs = local.azs

  name = "${local.prefix}-bar"
  cidr = "10.20.0.0/16"
  private_subnets = [
    "10.20.1.0/24",
    "10.20.2.0/24",
    "10.20.3.0/24",
  ]
}
