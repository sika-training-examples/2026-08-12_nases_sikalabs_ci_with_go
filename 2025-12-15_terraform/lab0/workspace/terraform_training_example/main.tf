locals {
  prefix = "lab0"
}

locals {
  REGION = "fra1"
  IMAGE = {
    DEBIAN = "debian-13-x64"
  }
  SIZE = {
    SMALL  = "s-1vcpu-1gb"
    MEDIUM = "s-2vcpu-2gb"
  }
}

module "db" {
  source = "./modules/db"
  name   = "db"

  prefix = local.prefix
}

module "foo_db" {
  source = "./modules/db"
  name   = "foo"

  prefix = local.prefix
}

resource "digitalocean_ssh_key" "default" {
  name       = local.prefix
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC1MGivhP6SoEx7iAzn6KM/mHH04UqAKhXmmwtlR76LqEMqKUuFKVexz1HtTEy+/VivGH6DXmd/Rw0pnzvOgR6kYojbvrPsuHYjUAhqVQCKbDmvMy8eN4VjWOKuENT4nkbkyIrYulRFdrn933nS/hZV3IEi+JLm8tbfsc5n4B4/DsoCZ3jizKkfQfSEpXU4qmEst7hXO43rNL0vXOJWvKoOXV80WDG7kJGyS6yyTdFlGnz+uWwO0WN0TK3t7zVbabEuptXv7CJ9Ib9YDnu+S36GSp+Nx//kYKIU6xcljgxCy1I7DTpn1+ab/MWOT64RgbJ9g1blLnH4fc+0xGaMOw7sfIDIF5HOo2GqUWlXOWFbb07ied0z5OdiWJRv04KhaehxuYpfqVQX5Fs5ODELKZGEhvuPeLx2AUAcxtJ939EPMlgfpA8WNffS3RJtyKYWD0kjtMg7lJzCQM12JMMGt1DIT8ZXbp2YXieR3VNl5jagdkJ2WN+zRxC69Uat2vhP+c8= root@lab0"
}

data "digitalocean_ssh_key" "ondrejsika" {
  name = "ondrejsika"
}

resource "digitalocean_droplet" "example" {
  image  = local.IMAGE.DEBIAN
  name   = "${local.prefix}-example"
  region = local.REGION
  size   = local.SIZE.SMALL
  ssh_keys = [
    digitalocean_ssh_key.default.fingerprint,
    data.digitalocean_ssh_key.ondrejsika.fingerprint,
  ]
}

output "ip" {
  value = digitalocean_droplet.example.ipv4_address
}

resource "digitalocean_container_registry" "default" {
  region                 = local.REGION
  name                   = local.prefix
  subscription_tier_slug = "starter"
}

resource "digitalocean_container_registry_docker_credentials" "default" {
  registry_name = digitalocean_container_registry.default.name
}

output "registry_credentials" {
  value     = digitalocean_container_registry_docker_credentials.default.docker_credentials
  sensitive = true
}
