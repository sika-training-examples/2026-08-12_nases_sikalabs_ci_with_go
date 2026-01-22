module "foo_ec2" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "6.2.0"

  name = "${local.prefix}-foo"

  instance_type               = "t3a.nano" // 2 CPU, 0.5 RAM https://cloudprice.net/aws/ec2/instances/t3a.nano
  subnet_id                   = module.foo_vpc.private_subnets[0]
  associate_public_ip_address = true

  key_name = module.key_pair.key_pair_name
  vpc_security_group_ids = [
    aws_security_group.foo.id,
  ]
}

output "ec2_foo_ip" {
  value = module.foo_ec2.public_ip
}
