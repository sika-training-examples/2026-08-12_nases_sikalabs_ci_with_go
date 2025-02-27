resource "keycloak_openid_client" "example2_provider" {
  realm_id                        = keycloak_realm.example.id
  client_id                       = "example2_provider"
  enabled                         = true
  standard_flow_enabled           = true
  direct_access_grants_enabled    = true
  access_type                     = "CONFIDENTIAL"
  valid_redirect_uris             = ["*"]
  valid_post_logout_redirect_uris = ["*"]
  web_origins                     = ["*"]
}
