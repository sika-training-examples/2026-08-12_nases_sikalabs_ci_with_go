resource "keycloak_role" "editor" {
  realm_id = keycloak_realm.prod.id
  name     = "editor"
}

resource "keycloak_role" "viewer" {
  realm_id = keycloak_realm.prod.id
  name     = "viewer"
}

resource "keycloak_role" "admin" {
  realm_id = keycloak_realm.prod.id
  name     = "admin"

  composite_roles = [
    keycloak_role.editor.id,
    keycloak_role.viewer.id,
  ]
}

resource "keycloak_role" "grafana_editor" {
  realm_id = keycloak_realm.prod.id
  name     = "grafana-editor"
}

resource "keycloak_role" "grafna_admin" {
  realm_id = keycloak_realm.prod.id
  name     = "grafana-admin"
}
