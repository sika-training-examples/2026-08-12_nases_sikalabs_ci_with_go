terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
    }
  }
}

variable "name" {}
variable "image" {
  validation {
    condition     = var.image == "DEBIAN" || var.image == "UBUNTU"
    error_message = "The image value must be 'DEBIAN' or 'UBUNTU'."
  }
}
variable "region" {}

locals {
  image = {
    DEBIAN = "debian-12-x64"
    UBUNTU = "ubuntu-22-04-x64"
  }[var.image]
  region = {
    EU = "fra1"
    US = "nyc3"
  }[var.region]
}

resource "digitalocean_droplet" "this" {
  image  = local.image
  name   = var.name
  region = local.region
  size   = "s-1vcpu-1gb"
}

output "ip" {
  value = digitalocean_droplet.this.ipv4_address
}
