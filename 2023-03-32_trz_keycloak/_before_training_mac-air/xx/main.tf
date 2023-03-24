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
  realm                    = "example"
  enabled                  = true
  display_name             = "Example SSO"
  display_name_html        = "<h1>Example SSO</h1>"
  registration_allowed     = true
  login_with_email_allowed = true
  reset_password_allowed   = true
  smtp_server {
    host = "maildev-smtp.maildev"
    port = "25"
    from = "sso@example.com"
    auth {
      username = "xxx"
      password = "xxx"
    }
  }
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


resource "keycloak_role" "editor" {
  realm_id = keycloak_realm.example.id
  name     = "editor"
}

resource "keycloak_role" "viewer" {
  realm_id = keycloak_realm.example.id
  name     = "viewer"
}

resource "keycloak_group" "team-a" {
  realm_id = keycloak_realm.example.id
  name     = "team-a"
}

resource "keycloak_group" "team-b" {
  realm_id = keycloak_realm.example.id
  name     = "team-b"
}

resource "keycloak_group_roles" "team-a" {
  realm_id = keycloak_realm.example.id
  group_id = keycloak_group.team-a.id

  role_ids = [
    keycloak_role.editor.id,
  ]
}

resource "keycloak_group_roles" "team-b" {
  realm_id = keycloak_realm.example.id
  group_id = keycloak_group.team-b.id

  role_ids = [
    keycloak_role.viewer.id,
  ]
}


resource "keycloak_user_roles" "ondrej" {
  realm_id = keycloak_realm.example.id
  user_id  = keycloak_user.ondrej.id

  role_ids = [
    keycloak_role.editor.id,
  ]
}

resource "keycloak_user_groups" "ondrej" {
  realm_id = keycloak_realm.example.id
  user_id  = keycloak_user.ondrej.id
  group_ids = [
    keycloak_group.team-b.id,
  ]
}


resource "keycloak_openid_client" "example" {
  realm_id                        = keycloak_realm.example.id
  client_id                       = "example"
  client_secret                   = "example"
  enabled                         = true
  standard_flow_enabled           = true
  access_type                     = "PUBLIC" # or "CONFIDENTIAL"
  valid_redirect_uris             = ["*"]
  valid_post_logout_redirect_uris = ["*"]
  web_origins                     = ["*"]
  consent_required                = true
}

resource "keycloak_openid_client_scope" "example_groups" {
  realm_id               = keycloak_realm.example.id
  name                   = "groups"
  consent_screen_text    = "Groups XXX"
  include_in_token_scope = true
}

resource "keycloak_openid_group_membership_protocol_mapper" "example_groups" {
  realm_id        = keycloak_realm.example.id
  client_scope_id = keycloak_openid_client_scope.example_groups.id
  name            = keycloak_openid_client_scope.example_groups.name
  claim_name      = keycloak_openid_client_scope.example_groups.name
  full_path       = false
}

data "keycloak_openid_client_scope" "example_roles" {
  realm_id = keycloak_realm.example.id
  name     = "roles"
}

resource "keycloak_openid_user_realm_role_protocol_mapper" "example_roles" {
  realm_id        = keycloak_realm.example.id
  client_scope_id = data.keycloak_openid_client_scope.example_roles.id
  name            = "roles"
  claim_name      = "roles"
  multivalued     = true
  # full_path       = false
}

resource "keycloak_openid_client_default_scopes" "example" {
  realm_id  = keycloak_realm.example.id
  client_id = keycloak_openid_client.example.id
  default_scopes = [
    "profile",
    "email",
    keycloak_openid_client_scope.example_groups.name,
    data.keycloak_openid_client_scope.example_roles.name,
  ]
}
