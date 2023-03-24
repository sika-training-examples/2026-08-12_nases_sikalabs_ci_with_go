terraform {
  required_providers {
    keycloak = {
      source  = "mrparkers/keycloak"
      version = "4.2.0"
    }
  }
}

provider "keycloak" {
  url       = "http://127.0.0.1:8080"
  client_id = "admin-cli"
  username  = "admin"
  password  = "admin"
}

resource "keycloak_realm" "example" {
  realm                  = "example"
  enabled                = true
  display_name           = "Example SSO"
  display_name_html      = "<h1>Example SSO</h1>"
  reset_password_allowed = true
  otp_policy {
    type = "totp"
  }
  login_theme = "sikalabs"

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

resource "keycloak_openid_client_scope" "example_groups" {
  realm_id               = keycloak_realm.example.id
  name                   = "groups"
  include_in_token_scope = true
}

resource "keycloak_openid_group_membership_protocol_mapper" "example_groups" {
  realm_id        = keycloak_realm.example.id
  client_scope_id = keycloak_openid_client_scope.example_groups.id
  name            = keycloak_openid_client_scope.example_groups.name
  claim_name      = keycloak_openid_client_scope.example_groups.name
  full_path       = false
}

resource "keycloak_openid_client" "example" {
  realm_id      = keycloak_realm.example.id
  client_id     = "example"
  client_secret = "example"

  name    = "example client"
  enabled = true

  standard_flow_enabled = true
  access_type           = "CONFIDENTIAL"
  valid_redirect_uris = [
    "*"
  ]

  login_theme = "keycloak"
}

resource "keycloak_openid_client_default_scopes" "example" {
  realm_id  = keycloak_realm.example.id
  client_id = keycloak_openid_client.example.id
  default_scopes = [
    "profile",
    "email",
    keycloak_openid_client_scope.example_groups.name,
  ]
}

resource "keycloak_group" "foo" {
  realm_id = keycloak_realm.example.id
  name     = "g-foo"
}

resource "keycloak_group" "bar" {
  realm_id = keycloak_realm.example.id
  name     = "g-bar"
}

resource "keycloak_user" "ondrej" {
  realm_id = keycloak_realm.example.id
  username = "ondrej"
  enabled  = true

  email          = "ondrej@example.com"
  email_verified = true
  first_name     = "Ondrej"
  last_name      = "Sika"

  initial_password {
    value     = "a"
    temporary = true
  }
}

resource "keycloak_user_groups" "ondrej" {
  realm_id = keycloak_realm.example.id
  user_id  = keycloak_user.ondrej.id
  group_ids = [
    keycloak_group.foo.id,
    keycloak_group.bar.id,
  ]
}

