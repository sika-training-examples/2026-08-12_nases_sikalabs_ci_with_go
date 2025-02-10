resource "keycloak_user" "ondrej" {
  lifecycle {
    ignore_changes = [
      required_actions,
    ]
  }

  for_each = local.realms

  realm_id = each.value
  username = "ondrej"
  enabled  = true

  email          = "ondrej@example.com"
  email_verified = true
  first_name     = "Ondrej"
  last_name      = "Sika"

  initial_password {
    value     = "a"
    temporary = true
  }
}

resource "keycloak_user_groups" "ondrej" {
  realm_id = keycloak_realm.prod.id
  user_id  = keycloak_user.ondrej["prod"].id

  group_ids = [
    keycloak_group.grafana_admins.id,
  ]
}

resource "keycloak_user_roles" "ondrej" {
  realm_id = keycloak_realm.prod.id
  user_id  = keycloak_user.ondrej["prod"].id

  role_ids = [
    keycloak_role.admin.id,
    keycloak_role.editor.id,
    keycloak_role.grafna_admin.id,
  ]
}
