resource "keycloak_openid_client" "realm2_grafana" {
  realm_id                        = keycloak_realm.realm2.id
  client_id                       = "grafana"
  client_secret                   = "grafana_secret"
  enabled                         = true
  standard_flow_enabled           = true
  direct_access_grants_enabled    = true
  access_type                     = "CONFIDENTIAL"
  valid_redirect_uris             = ["*"]
  valid_post_logout_redirect_uris = ["*"]
  web_origins                     = ["*"]
}

resource "keycloak_openid_client_optional_scopes" "realm2_grafana" {
  realm_id  = keycloak_realm.realm2.id
  client_id = keycloak_openid_client.realm2_grafana.id

  optional_scopes = [
    keycloak_openid_client_scope.realm2_groups.name,
  ]
}
