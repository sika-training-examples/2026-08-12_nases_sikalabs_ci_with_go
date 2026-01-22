data "aws_caller_identity" "current" {}
data "aws_availability_zones" "available" {}

locals {
  name    = "complete-postgresql"
  region  = "eu-west-1"
  region2 = "eu-central-1"

  vpc_cidr = "10.0.0.0/16"
  azs      = slice(data.aws_availability_zones.available.names, 0, 3)
}
