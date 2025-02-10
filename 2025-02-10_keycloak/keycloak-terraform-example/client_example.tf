resource "keycloak_openid_client" "example" {
  realm_id                        = keycloak_realm.prod.id
  client_id                       = "example"
  enabled                         = true
  standard_flow_enabled           = true
  direct_access_grants_enabled    = true
  access_type                     = "CONFIDENTIAL"
  valid_redirect_uris             = ["*"]
  valid_post_logout_redirect_uris = ["*"]
  web_origins                     = ["*"]
}

output "client_secret_example" {
  value     = keycloak_openid_client.example.client_secret
  sensitive = true
}
