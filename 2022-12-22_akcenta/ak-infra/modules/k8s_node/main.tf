variable "name" {
  type = string
}

variable "zone_id" {
  type = string
}

variable "ssh_keys" {
  type = list(number)
}

variable "user_data" {
  type = string
}

module "this" {
  source  = "ondrejsika/ondrejsika-do-droplet/module"
  version = "1.2.0"

  size         = "s-2vcpu-4gb"
  image        = "debian-11-x64"
  tf_ssh_keys  = var.ssh_keys
  zone_id      = var.zone_id
  droplet_name = var.name
  record_name  = var.name
  user_data    = var.user_data
}

output "hostname" {
  value = module.this.record.hostname
}

output "ipv4_address" {
  value = module.this.droplet.ipv4_address
}

output "droplet_id" {
  value = module.this.droplet.id
}
