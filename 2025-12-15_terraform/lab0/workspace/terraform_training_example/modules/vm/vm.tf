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

variable "size" {
  type = string
}

variable "image" {
  type = string
}

variable "user_data" {
  type    = string
  default = null
}

variable "ssh_keys" {
  type = list(string)
}

variable "env" {
  type = string
}

resource "digitalocean_droplet" "this" {
  lifecycle {
    prevent_destroy = true
    ignore_changes = [
      tags,
      user_data,
      ssh_keys,
    ]
  }

  image    = var.image
  name     = "${var.prefix}-${var.name}"
  region   = var.region
  size     = var.size
  ssh_keys = var.ssh_keys
  tags = [
    "created-${formatdate("YYYY-MM-DD-hh-mm-ss", timestamp())}",
    "env-${var.env},"
  ]

  user_data = var.user_data
}

output "ip" {
  value = digitalocean_droplet.this.ipv4_address
}
