resource "keycloak_openid_client" "public" {
  realm_id                        = keycloak_realm.prod.id
  client_id                       = "public"
  enabled                         = true
  standard_flow_enabled           = true
  direct_access_grants_enabled    = true
  access_type                     = "PUBLIC"
  valid_redirect_uris             = ["*"]
  valid_post_logout_redirect_uris = ["*"]
  web_origins                     = ["*"]
}
