variable "base_domain" {}

terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
    }
  }
  required_version = ">= 0.13"
}

provider "digitalocean" {}

data "digitalocean_ssh_key" "default" {
  name = "lab0"
}

data "digitalocean_domain" "default" {
  name = var.base_domain
}

locals {
  vms = toset([for i in range(0, 1) : format("%d", i)])
}

resource "digitalocean_droplet" "example" {
  for_each = local.vms

  image  = "debian-11-x64"
  name   = "example-${each.key}"
  region = "fra1"
  size   = "s-1vcpu-1gb"
  ssh_keys = [
    data.digitalocean_ssh_key.default.fingerprint
  ]
}

resource "digitalocean_record" "example" {
  for_each = local.vms


  domain = data.digitalocean_domain.default.name
  type   = "A"
  name   = digitalocean_droplet.example[each.key].name
  value  = digitalocean_droplet.example[each.key].ipv4_address
}

output "domains" {
  value = [
    for instance in digitalocean_record.example : instance.fqdn
  ]
}
