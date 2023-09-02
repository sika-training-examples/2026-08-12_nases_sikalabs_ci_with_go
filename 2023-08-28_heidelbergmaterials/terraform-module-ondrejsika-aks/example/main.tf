terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.71.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "4.13.0"
    }
  }
}

provider "azurerm" {
  features {}
}

variable "cloudflare_api_token" {}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

variable "cloudflare_zone_id" {}

module "aks" {
  source = "./.."

  location = "westeurope"
  common_tags = {
    "foo" = "bar"
  }
  name               = "aks-example"
  dns_record_name    = "aks-example"
  node_count         = 3
  node_size          = "Standard_D2ads_v5"
  cloudflare_zone_id = var.cloudflare_zone_id
}

output "kubeconfig" {
  value     = module.aks.kubeconfig
  sensitive = true
}

output "ingress_resource_group_name" {
  value = module.aks.ingress_resource_group_name
}

output "ingress_ip" {
  value = module.aks.ingress_ip
}

output "ingress_base_domain" {
  value = module.aks.ingress_base_domain
}
