resource "keycloak_openid_client" "vault" {
  realm_id              = keycloak_realm.pss.id
  client_id             = "vault"
  name                  = "vault"
  enabled               = true
  access_type           = "CONFIDENTIAL"
  standard_flow_enabled = true
  valid_redirect_uris = [
    "*",
  ]
}

resource "keycloak_openid_audience_protocol_mapper" "vault" {
  realm_id                 = keycloak_realm.pss.id
  client_id                = keycloak_openid_client.vault.id
  name                     = "audience-mapper"
  included_client_audience = keycloak_openid_client.vault.client_id
}

resource "keycloak_openid_client_default_scopes" "vault" {
  realm_id  = keycloak_realm.pss.id
  client_id = keycloak_openid_client.vault.id
  default_scopes = [
    "profile",
    "email",
    keycloak_openid_client_scope.pss_groups.name,
  ]
}

output "vault_client_secret" {
  value     = keycloak_openid_client.vault.client_secret
  sensitive = true
}
