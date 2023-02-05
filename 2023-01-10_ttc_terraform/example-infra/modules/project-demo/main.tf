variable "config" {}

data "digitalocean_ssh_key" "default" {
  name = var.config.ssh_key_name
}

module "db" {
  source = "../../modules/vm"
  name   = "${var.config.env}-db"
  ssh_keys = [
    data.digitalocean_ssh_key.default.id,
  ]
}

module "vm" {
  for_each = var.config.vms

  source = "../../modules/vm"
  name   = "${var.config.env}-${each.key}"
  ssh_keys = [
    data.digitalocean_ssh_key.default.id,
  ]
}

output "ips" {
  value = {
    for k, v in module.vm : k => v.ipv4_address
  }
}
