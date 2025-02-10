resource "keycloak_realm" "test" {
  realm                  = "test"
  enabled                = true
  display_name           = "SSO TEST"
  reset_password_allowed = true
  login_theme            = "ondrejsika"
  verify_email           = true
  smtp_server {
    host = "maildev-smtp.example-keycloak"
    port = "25"
    from = "sso-test@sikademo.com"
  }
}

# resource "keycloak_oidc_identity_provider" "test_prod" {
#   realm             = keycloak_realm.test.id
#   alias             = "prod"
#   authorization_url = "https://keycloak.sikademo.com/realms/prod/protocol/openid-connect/auth"
#   client_id         = keycloak_openid_client.keycloak.client_id
#   client_secret     = keycloak_openid_client.keycloak.client_secret
#   token_url         = "https://keycloak.sikademo.com/realms/prod/protocol/openid-connect/token"
#   issuer            = "https://keycloak.sikademo.com/realms/prod"
# }
