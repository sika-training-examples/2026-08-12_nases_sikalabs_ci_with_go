module "redis" {
  source = "../../modules/redis"

  name = "dev-example"
}

data "digitalocean_ssh_key" "this" {
  name = "default"
}

module "vm" {
  source = "../../modules/vm"

  name = "dev-example"
  ssh_keys = [
    data.digitalocean_ssh_key.this.id
  ]
  domain_id = "do-2024-02-20-0.sikademo.com"
}
