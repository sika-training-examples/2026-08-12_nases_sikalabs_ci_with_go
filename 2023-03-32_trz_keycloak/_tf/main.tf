terraform {
  required_providers {
    keycloak = {
      source = "mrparkers/keycloak"
    }
  }
}

provider "keycloak" {
  client_id = "admin-cli"
  url       = "http://localhost:8080"
  username  = "admin"
  password  = "admin"
}

resource "keycloak_realm" "example" {
  realm                  = "example"
  enabled                = true
  display_name           = "Example SSO"
  display_name_html      = "<h1>Example SSO</h1>"
  reset_password_allowed = true
  smtp_server {
    host = "mailhog"
    port = "1025"
    from = "sso@example.com"
    auth {
      username = "xxx"
      password = "xxx"
    }
  }
}
