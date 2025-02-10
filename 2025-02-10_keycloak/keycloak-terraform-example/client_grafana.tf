resource "keycloak_openid_client" "grafana" {
  realm_id                        = keycloak_realm.prod.id
  client_id                       = "grafana"
  enabled                         = true
  standard_flow_enabled           = true
  direct_access_grants_enabled    = true
  access_type                     = "CONFIDENTIAL"
  valid_redirect_uris             = ["*"]
  valid_post_logout_redirect_uris = ["*"]
  web_origins                     = ["*"]
}

resource "keycloak_openid_client_default_scopes" "grafana" {
  realm_id  = keycloak_realm.prod.id
  client_id = keycloak_openid_client.grafana.id
  default_scopes = [
    "profile",
    "email",
    keycloak_openid_client_scope.groups.name,
  ]
}

output "client_secret_grafana" {
  value     = keycloak_openid_client.grafana.client_secret
  sensitive = true
}
