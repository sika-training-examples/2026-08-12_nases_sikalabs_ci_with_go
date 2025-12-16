variable "prefix" {
  type = string
}

variable "name" {
  type = string
}

variable "region" {
  type    = string
  default = "fra1"
}

resource "digitalocean_database_cluster" "this" {
  name       = "${var.prefix}-${var.name}"
  engine     = "pg"
  version    = "15"
  size       = "db-s-1vcpu-1gb"
  region     = var.region
  node_count = 1
}
