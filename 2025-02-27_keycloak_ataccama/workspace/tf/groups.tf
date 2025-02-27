resource "keycloak_group" "argocd-admins" {
  realm_id = keycloak_realm.example.id
  name     = "argocd-admins"
}

resource "keycloak_group" "argocd-viewers" {
  realm_id = keycloak_realm.example.id
  name     = "argocd-viewers"
}

resource "keycloak_group" "grafana-admins" {
  realm_id = keycloak_realm.example.id
  name     = "grafana-admins"
}

resource "keycloak_group" "grafana-viewers" {
  realm_id = keycloak_realm.example.id
  name     = "grafana-viewers"
}
