resource "keycloak_realm" "prod" {
  realm                  = "prod"
  enabled                = true
  display_name           = "SSO PROD"
  reset_password_allowed = true
  login_theme            = "sika-io"
  verify_email           = true
  smtp_server {
    host = "maildev-smtp.example-keycloak"
    port = "25"
    from = "sso-prod@sikademo.com"
  }
}

resource "keycloak_openid_client_scope" "groups" {
  realm_id               = keycloak_realm.prod.id
  name                   = "groups"
  include_in_token_scope = true
}

resource "keycloak_openid_group_membership_protocol_mapper" "groups" {
  realm_id        = keycloak_realm.prod.id
  client_scope_id = keycloak_openid_client_scope.groups.id

  name       = "groups"
  claim_name = "groups"
  full_path  = false
}
