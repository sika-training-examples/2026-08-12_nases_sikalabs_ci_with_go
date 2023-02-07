output "name" {
  value = digitalocean_droplet.this.name
}

output "ip" {
  value = digitalocean_droplet.this.ipv4_address
}

output "domain" {
  value = cloudflare_record.this.hostname
}
