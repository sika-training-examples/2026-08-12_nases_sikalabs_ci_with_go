resource "keycloak_openid_client" "keycloak" {
  realm_id                     = keycloak_realm.prod.id
  client_id                    = "keycloak"
  enabled                      = true
  standard_flow_enabled        = true
  direct_access_grants_enabled = true
  access_type                  = "CONFIDENTIAL"
  valid_redirect_uris = [
    "https://keycloak.sikademo.com/realms/test/broker/prod/endpoint",
  ]
}

resource "keycloak_openid_client_default_scopes" "keycloak" {
  realm_id  = keycloak_realm.prod.id
  client_id = keycloak_openid_client.keycloak.id
  default_scopes = [
    "profile",
    "email",
    keycloak_openid_client_scope.groups.name,
  ]
}

output "client_secret_keycloak" {
  value     = keycloak_openid_client.keycloak.client_secret
  sensitive = true
}
