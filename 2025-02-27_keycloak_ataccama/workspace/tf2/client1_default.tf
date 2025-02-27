resource "keycloak_openid_client" "realm1_default" {
  realm_id                        = keycloak_realm.realm1.id
  client_id                       = "default"
  client_secret                   = "default_secret"
  enabled                         = true
  standard_flow_enabled           = true
  direct_access_grants_enabled    = true
  access_type                     = "CONFIDENTIAL"
  valid_redirect_uris             = ["*"]
  valid_post_logout_redirect_uris = ["*"]
  web_origins                     = ["*"]
}

resource "keycloak_openid_audience_protocol_mapper" "realm1_default" {
  realm_id  = keycloak_realm.realm1.id
  client_id = keycloak_openid_client.realm1_default.id
  name      = "audience-mapper"

  included_custom_audience = keycloak_openid_client.realm1_default.client_id
}

resource "keycloak_openid_client_default_scopes" "realm1_default" {
  realm_id  = keycloak_realm.realm1.id
  client_id = keycloak_openid_client.realm1_default.id

  default_scopes = [
    "roles",
  ]
}

resource "keycloak_role" "realm1-editor" {
  realm_id  = keycloak_realm.realm1.id
  client_id = keycloak_openid_client.realm1_default.id
  name      = "editor"
}

resource "keycloak_role" "realm1-viewer" {
  realm_id  = keycloak_realm.realm1.id
  client_id = keycloak_openid_client.realm1_default.id
  name      = "viewer"
}

resource "keycloak_openid_client_optional_scopes" "realm1_default" {
  realm_id  = keycloak_realm.realm1.id
  client_id = keycloak_openid_client.realm1_default.id

  optional_scopes = [
    "email",
    "profile",
    keycloak_openid_client_scope.realm1_groups.name,
    keycloak_openid_client_scope.realm1_department.name,
  ]
}
