resource "digitalocean_droplet" "this" {
  image    = var.image
  name     = var.name
  region   = var.region
  size     = var.size
  ssh_keys = var.ssh_keys
}
