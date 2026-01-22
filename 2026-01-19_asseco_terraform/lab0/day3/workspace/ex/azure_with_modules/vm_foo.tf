module "foo_vm" {
  source = "./modules/vm"

  resource_group_name = azurerm_resource_group.training.name
  location            = azurerm_resource_group.training.location
  tags                = local.common_tags

  name                       = "${local.prefix}-foo"
  subnet_id                  = module.foo_net.subnet_ids["01"]
  private_ip_address         = "10.10.10.101"
  public_ip_address_id       = azurerm_public_ip.foo.id
  size                       = local.size
  public_key                 = local.public_key
  network_security_group_ids = local.vm_network_security_group_ids
}

output "ssh_foo" {
  value = "ssh azadmin@${azurerm_public_ip.foo.ip_address}"
}
