terraform {
  required_providers {
    keycloak = {
      source = "mrparkers/keycloak"
    }
  }
}

provider "keycloak" {
  client_id = "admin-cli"
  url       = "https://keycloak.sikademo.com"
  username  = "admin"
  password  = "admin"
}

resource "keycloak_realm" "example" {
  realm                  = "example"
  enabled                = true
  display_name           = "SSO"
  display_name_html      = "<h1 style=\"color: red; font-size: 2em\">SSO</h1>"
  reset_password_allowed = true
  remember_me            = true
  smtp_server {
    host                  = "mailhog"
    port                  = "1025"
    from                  = "sso@example.com"
    from_display_name     = "Example SSO"
    reply_to              = "support@example.com"
    reply_to_display_name = "Example Support"
    auth {
      username = "xxx"
      password = "xxx"
    }
  }
  security_defenses {
    headers {
      content_security_policy = "frame-src *; frame-ancestors *; object-src *;"
    }
  }
}

resource "keycloak_openid_client_scope" "example_groups" {
  realm_id               = keycloak_realm.example.id
  name                   = "groups"
  include_in_token_scope = true
}

resource "keycloak_openid_client_scope" "example_audience" {
  realm_id               = keycloak_realm.example.id
  name                   = "audience"
  include_in_token_scope = true
}
