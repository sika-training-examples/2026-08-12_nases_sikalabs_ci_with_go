resource "keycloak_group" "argocd_admins" {
  realm_id = keycloak_realm.pss.id
  name     = "argocd_admins"
}

resource "keycloak_group" "vault_admins" {
  realm_id = keycloak_realm.pss.id
  name     = "vault_admins"
}

resource "keycloak_group" "hello_pss_dev" {
  realm_id = keycloak_realm.pss.id
  name     = "hello_pss_dev"
}

resource "keycloak_group" "hello_pss_prod" {
  realm_id = keycloak_realm.pss.id
  name     = "hello_pss_prod"
}

