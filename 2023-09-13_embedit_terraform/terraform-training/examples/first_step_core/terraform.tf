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

data "digitalocean_ssh_key" "shit" {
  name = "lab0"
}

data "digitalocean_domain" "default" {
  name = var.base_domain
}

resource "digitalocean_droplet" "example" {
  lifecycle {
    ignore_changes = [ssh_keys]
  }

  image  = "debian-12-x64"
  name   = "example"
  region = "fra1"
  size   = "s-1vcpu-1gb"
  ssh_keys = [
    # data.digitalocean_ssh_key.shit.id
  ]
}

resource "digitalocean_record" "example" {
  domain = data.digitalocean_domain.default.name
  type   = "A"
  name   = digitalocean_droplet.example.name
  value  = digitalocean_droplet.example.ipv4_address
}

output "domain" {
  value = digitalocean_record.example.fqdn
}
