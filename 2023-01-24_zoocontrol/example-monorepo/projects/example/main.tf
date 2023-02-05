variable "prefix" {
  type = string
}
variable "zone_id" {
  type = string
}
variable "instance_type" {
  type = string
}

locals {
  prefix  = var.prefix
  zone_id = var.zone_id
}

resource "aws_key_pair" "default" {
  key_name   = "${local.prefix}-default"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCslNKgLyoOrGDerz9pA4a4Mc+EquVzX52AkJZz+ecFCYZ4XQjcg2BK1P9xYfWzzl33fHow6pV/C6QC3Fgjw7txUeH7iQ5FjRVIlxiltfYJH4RvvtXcjqjk8uVDhEcw7bINVKVIS856Qn9jPwnHIhJtRJe9emE7YsJRmNSOtggYk/MaV2Ayx+9mcYnA/9SBy45FPHjMlxntoOkKqBThWE7Tjym44UNf44G8fd+kmNYzGw9T5IKpH1E1wMR+32QJBobX6d7k39jJe8lgHdsUYMbeJOFPKgbWlnx9VbkZh+seMSjhroTgniHjUl8wBFgw0YnhJ/90MgJJL4BToxu9PVnH"
}

resource "aws_vpc" "default" {
  cidr_block = "10.0.0.0/16"
}

module "vm" {
  source        = "../../modules/ec2"
  zone_id       = local.zone_id
  name          = "${local.prefix}-hello"
  key_name      = aws_key_pair.default.key_name
  instance_type = var.instance_type
}

output "domain" {
  value = module.vm.domain
}
