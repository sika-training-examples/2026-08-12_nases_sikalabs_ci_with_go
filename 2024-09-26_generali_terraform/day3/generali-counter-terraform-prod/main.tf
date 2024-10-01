terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.3"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "200acaec-2d60-43ad-915a-e8f5352a4ba7"
}

module "generali_counter_prod" {
  source = "git::https://gitlab.sikademo.com/generali/generali-counter-terraform.git?ref=master"

  env      = "prod"
  suffix   = "ondrejsika"
  replicas = 2
  firewall_rules = {
    all = {
      start_ip_address = "0.0.0.0"
      end_ip_address   = "255.255.255.255"
    }
  }
}

output "generali_counter_prod" {
  value     = module.generali_counter_prod
  sensitive = true
}

output "generali_counter_prod_url" {
  value = module.generali_counter_prod.counter_url
}
