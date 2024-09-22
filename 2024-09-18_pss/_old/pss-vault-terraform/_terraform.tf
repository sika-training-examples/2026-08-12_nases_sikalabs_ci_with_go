terraform {
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "3.4.1"
    }
    random = {
      source = "hashicorp/random"
    }
  }
}

variable "vault_address" {
  type = string
}

variable "vault_token" {
  type = string
}

provider "vault" {
  address = var.vault_address
  token   = var.vault_token
}
