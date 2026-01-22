module "foo_vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.6.0"

  azs = local.azs

  name = "${local.prefix}-foo"
  cidr = "10.10.0.0/16"


  private_subnets = [
    "10.10.1.0/24",
    "10.10.2.0/24",
    "10.10.3.0/24",
  ]
}

resource "aws_security_group" "foo" {
  name   = "${local.prefix}-foo-sg"
  vpc_id = module.foo_vpc.vpc_id

  tags = {
    Name = "${local.prefix}-foo-sg"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
