resource "aws_vpc_peering_connection" "peering" {
  vpc_id      = module.foo_vpc.vpc_id
  peer_vpc_id = module.bar_vpc.vpc_id
}
