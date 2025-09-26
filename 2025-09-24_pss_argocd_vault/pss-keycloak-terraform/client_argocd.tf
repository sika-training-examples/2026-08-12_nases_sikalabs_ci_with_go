resource "keycloak_openid_client" "argocd" {
  realm_id                     = keycloak_realm.pss.id
  client_id                    = "argocd"
  name                         = "argocd"
  enabled                      = true
  access_type                  = "CONFIDENTIAL"
  standard_flow_enabled        = true
  direct_access_grants_enabled = true
  valid_redirect_uris = [
    "*",
  ]
  valid_post_logout_redirect_uris = [
    "*",
  ]
}

resource "keycloak_openid_client_default_scopes" "argocd" {
  realm_id  = keycloak_realm.pss.id
  client_id = keycloak_openid_client.argocd.id
  default_scopes = [
    "profile",
    "email",
    keycloak_openid_client_scope.pss_groups.name,
  ]
}

output "argocd_client_secret" {
  value     = keycloak_openid_client.argocd.client_secret
  sensitive = true
}
