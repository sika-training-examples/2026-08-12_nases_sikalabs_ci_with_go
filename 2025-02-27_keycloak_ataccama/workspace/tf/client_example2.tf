resource "keycloak_openid_client" "example2" {
  realm_id                        = keycloak_realm.example2.id
  client_id                       = "example"
  client_secret                   = "example_client_secret"
  enabled                         = true
  standard_flow_enabled           = true
  direct_access_grants_enabled    = true
  access_type                     = "CONFIDENTIAL"
  valid_redirect_uris             = ["*"]
  valid_post_logout_redirect_uris = ["*"]
  web_origins                     = ["*"]
}
