terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
    }
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }
}

provider "digitalocean" {}

provider "azurerm" {
  features {}
}

module "rg" {
  source = "./modules/rg_az"

  name   = "exampleembedit"
  region = "EU"
}

module "net" {
  source = "./modules/net_az"

  name                = module.rg.name
  resource_group_name = module.rg.name
  region              = "EU"
  range               = "10.250.0.0/16"
  subnets = [
    "10.250.0.0/24"
  ]
}

module "vm--db" {
  source = "./modules/vm_do"

  name   = "db"
  region = "EU"
  image  = "DEBIAN"
}

module "vm--app" {
  source = "./modules/vm_az"

  name   = "app"
  region = "EU"
  image  = "UBUNTU"

  resource_group_name = module.rg.name
  subnet_id           = module.net.subnet_ids[0]
}

output "ips" {
  value = {
    db  = module.vm--db.ip
    app = module.vm--app.ip
  }
}
