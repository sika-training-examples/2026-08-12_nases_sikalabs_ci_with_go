resource "keycloak_openid_client" "proxmox" {
  realm_id                        = keycloak_realm.prod.id
  client_id                       = "proxmox"
  enabled                         = true
  standard_flow_enabled           = true
  direct_access_grants_enabled    = true
  access_type                     = "CONFIDENTIAL"
  root_url                        = "https://sl-office-pve1.sl.zone:8006/"
  valid_redirect_uris             = ["*"]
  valid_post_logout_redirect_uris = ["*"]
  web_origins                     = ["*"]
}

resource "keycloak_openid_client_default_scopes" "proxmox" {
  realm_id  = keycloak_realm.prod.id
  client_id = keycloak_openid_client.proxmox.id
  default_scopes = [
    "profile",
    "email",
    keycloak_openid_client_scope.groups.name,
  ]
}

output "client_secret_proxmox" {
  value     = keycloak_openid_client.proxmox.client_secret
  sensitive = true
}
