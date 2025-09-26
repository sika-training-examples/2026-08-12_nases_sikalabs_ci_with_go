terraform {
  required_providers {
    keycloak = {
      source = "keycloak/keycloak"
    }
    slu = {
      source = "sikalabsx/slu"
    }
  }
}

variable "keycloak_url" {
  type        = string
  description = "Keycloak URL"
}

variable "keycloak_username" {
  type        = string
  description = "Keycloak Username"
}

variable "keycloak_password" {
  type        = string
  description = "Keycloak Password"
}

provider "keycloak" {
  client_id = "admin-cli"
  url       = var.keycloak_url
  username  = var.keycloak_username
  password  = var.keycloak_password
}
