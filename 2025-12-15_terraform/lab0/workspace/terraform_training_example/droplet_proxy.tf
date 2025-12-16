module "proxy_vm" {
  source = "git::https://github.com/sika-training-examples/2025-12-15_terraform_training_example.git//modules/vm"

  image  = local.IMAGE.DEBIAN
  prefix = local.prefix
  name   = "proxy"
  region = local.REGION
  size   = local.SIZE.SMALL
  env    = "training"
  ssh_keys = [
    digitalocean_ssh_key.default.fingerprint,
    data.digitalocean_ssh_key.ondrejsika.fingerprint,
  ]
}
