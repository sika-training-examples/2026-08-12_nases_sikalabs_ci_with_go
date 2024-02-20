terraform {
  required_version = ">= 1.6"
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "2.34.1"
    }
  }
}

variable "name" {
  description = "The name of the droplet"
  type        = string
}

resource "digitalocean_database_cluster" "this" {
  name       = var.name
  engine     = "redis"
  version    = "7"
  size       = "db-s-1vcpu-1gb"
  region     = "fra1"
  node_count = 1
}

output "redis" {
  value = digitalocean_database_cluster.this
}
