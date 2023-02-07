data "digitalocean_ssh_key" "default" {
  name = "ondrejsika"
}

module "example" {
  source   = "../../applications/example"
  prefix   = "prod"
  db_count = 2
  zone_id  = "f2c00168a7ecd694bb1ba017b332c019"
  ssh_keys = [
    data.digitalocean_ssh_key.default.id,
  ]
  vms = jsondecode(file("vms.json"))
}

output "example" {
  value = module.example
}

output "example-ansible-hosts" {
  value = module.example.ansible-hosts
}
