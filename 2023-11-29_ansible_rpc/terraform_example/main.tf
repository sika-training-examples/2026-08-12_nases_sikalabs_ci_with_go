terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "2.32.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "4.20.0"
    }
  }
}

provider "digitalocean" {}
provider "cloudflare" {}

data "digitalocean_ssh_key" "default" {
  name = "ondrejsika"
}

resource "digitalocean_droplet" "example" {
  image  = "debian-12-x64"
  name   = "example-rpc"
  region = "fra1"
  size   = "s-1vcpu-1gb"
  ssh_keys = [
    data.digitalocean_ssh_key.default.id,
  ]
}

data "cloudflare_zone" "sikademo_com" {
  name = "sikademo.com"
}

resource "cloudflare_record" "example" {
  zone_id = data.cloudflare_zone.sikademo_com.id
  name    = digitalocean_droplet.example.name
  value   = digitalocean_droplet.example.ipv4_address
  type    = "A"
}

output "ip" {
  value = digitalocean_droplet.web.ipv4_address
}

output "fqdn" {
  value = cloudflare_record.web.hostname
}
