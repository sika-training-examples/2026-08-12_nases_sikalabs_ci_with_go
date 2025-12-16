module "web_vm" {
  source = "git::git@gitlab.sikademo.com:terraform/terraform.git//modules/vm"

  prefix = local.prefix
  image  = local.IMAGE.DEBIAN
  name   = "web"
  region = local.REGION
  size   = local.SIZE.MEDIUM
  env    = "training"
  ssh_keys = [
    digitalocean_ssh_key.default.fingerprint,
    data.digitalocean_ssh_key.ondrejsika.fingerprint,
  ]
  user_data = <<EOF
#cloud-config
ssh_pwauth: yes
password: asdfasdf2020
write_files:
- path: /html/index.html
  permissions: "0755"
  owner: root:root
  content: |
    <h1>Ahoj Svete z Cloud Init
chpasswd:
  expire: false
runcmd:
  - |
    apt update
    apt install -y curl sudo git nginx
    curl -fsSL https://ins.oxs.cz/slu-linux-amd64.sh | sudo sh
    cp /html/index.html /var/www/html/index.html
EOF
}

output "web_ip" {
  value = module.web_vm.ip
}

output "web_http" {
  value = "http://${module.web_vm.ip}"
}

moved {
  from = digitalocean_droplet.web
  to   = module.web_vm.digitalocean_droplet.this
}
