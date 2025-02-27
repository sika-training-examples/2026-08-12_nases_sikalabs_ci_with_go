resource "keycloak_openid_client" "realm1_idp" {
  realm_id                        = keycloak_realm.realm1.id
  client_id                       = "idp"
  client_secret                   = "idp_secret"
  enabled                         = true
  standard_flow_enabled           = true
  direct_access_grants_enabled    = true
  access_type                     = "CONFIDENTIAL"
  valid_redirect_uris             = ["*"]
  valid_post_logout_redirect_uris = ["*"]
  web_origins                     = ["*"]
}

resource "keycloak_openid_client_default_scopes" "realm1_idp" {
  realm_id  = keycloak_realm.realm1.id
  client_id = keycloak_openid_client.realm1_idp.id

  default_scopes = [
    "profile",
    "email",
    "roles",
    keycloak_openid_client_scope.realm1_myroles.name,
    keycloak_openid_client_scope.realm1_groups.name,
    keycloak_openid_client_scope.realm1_department.name,
  ]
}

resource "keycloak_openid_client_optional_scopes" "realm1_idp" {
  realm_id  = keycloak_realm.realm1.id
  client_id = keycloak_openid_client.realm1_idp.id

  optional_scopes = []
}
