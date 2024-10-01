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

module "generali_counter_dev" {
  source = "git::https://gitlab.sikademo.com/generali/generali-counter-terraform.git?ref=master"

  env    = "dev"
  suffix = "ondrejsika"
  firewall_rules = {
    all = {
      start_ip_address = "0.0.0.0"
      end_ip_address   = "255.255.255.255"
    }
  }
}

output "generali_counter_dev" {
  value     = module.generali_counter_dev
  sensitive = true
}
