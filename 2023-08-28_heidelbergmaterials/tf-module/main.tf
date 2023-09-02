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

provider "cloudflare" {
  api_token = base64decode("RHllSjZ3cDFKQmxXWXJacm5VYmM4T0JwWXdlWXRmUUgyU19famJycw==")
}

module "aks" {
  source  = "ondrejsika/ondrejsika-aks/module"
  version = "0.1.0"

  location = "westeurope"
  common_tags = {
    "foo" = "bar"
  }
  name               = "aks"
  dns_record_name    = "aks"
  node_count         = 3
  node_size          = "Standard_D2ads_v5"
  cloudflare_zone_id = "f2c00168a7ecd694bb1ba017b332c019" // sikademo.com
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
