terraform {
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
    }
    digitalocean = {
      source = "digitalocean/digitalocean"
    }
  }
}

variable "digitalocean_token" {}
provider "digitalocean" {
  token = var.digitalocean_token
}

variable "cloudflare_api_token" {}
provider "cloudflare" {
  api_token = var.cloudflare_api_token
}


module "local" {
  source = "../modules/vm-demo/do"

  droplet_name = "local-example"
  record_name  = "local-example"
}

module "gitlab" {
  source = "gitlab.sikademo.com/terraform/vm-demo/do"

  droplet_name = "gitlab-example"
  record_name  = "gitlab-example"
}
