resource "keycloak_realm" "example2" {
  realm                          = "example2"
  enabled                        = true
  display_name                   = "Example2 SSO"
  display_name_html              = "<h1>Example2 SSO</h1>"
  reset_password_allowed         = true
  registration_allowed           = true
  registration_email_as_username = false

  smtp_server {
    host = "maildev2.sikademo.com"
    port = "1025"
    from = "keycloak2@kc0.com"
  }
}


resource "keycloak_oidc_identity_provider" "example2" {
  realm             = keycloak_realm.example2.id
  alias             = "example"
  authorization_url = "https://kc0.k8s.sikademo.com/realms/example/protocol/openid-connect/auth"
  client_id         = keycloak_openid_client.example2_provider.client_id
  client_secret     = keycloak_openid_client.example2_provider.client_secret
  token_url         = "https://kc0.k8s.sikademo.com/realms/example/protocol/openid-connect/token"

  extra_config = {
    "clientAuthMethod" = "client_secret_post"
  }
}
