data "digitalocean_ssh_key" "ondrejsika" {
  name = "ondrejsika"
}

locals {
  ssh_keys = [
    data.digitalocean_ssh_key.ondrejsika.id,
  ]
}
