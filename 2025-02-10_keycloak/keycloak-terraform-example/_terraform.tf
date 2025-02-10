terraform {
  required_providers {
    keycloak = {
      source = "keycloak/keycloak"
    }
    smtp = {
      source  = "venkadeshwarank/smtp"
      version = "0.3.1"
    }
  }
}

variable "keycloak_password" {}

provider "keycloak" {
  client_id = "admin-cli"
  url       = "https://keycloak.sikademo.com"
  username  = "admin"
  password  = var.keycloak_password
}

provider "smtp" {
  authentication = false
  host           = "164.90.183.235"
  port           = "30756"
}
