resource "digitalocean_droplet" "this" {
  image    = var.image
  name     = var.name
  region   = var.region
  size     = var.size
  ssh_keys = var.ssh_keys
}

resource "cloudflare_record" "this" {
  zone_id = var.zone_id
  name    = digitalocean_droplet.this.name
  value   = digitalocean_droplet.this.ipv4_address
  type    = "A"
}
