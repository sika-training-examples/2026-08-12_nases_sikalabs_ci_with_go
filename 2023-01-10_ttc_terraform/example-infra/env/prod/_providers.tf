terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
    }
  }
}

variable "digitalocean_token" {
  type = string
}

provider "digitalocean" {
  token = var.digitalocean_token
}
