resource "keycloak_user" "jozef" {
  lifecycle {
    ignore_changes = [
      required_actions,
    ]
  }

  for_each = local.realms

  realm_id = each.value
  username = "jozef"
  enabled  = true

  email          = "jozef@example.com"
  email_verified = true
  first_name     = "jozef"
  last_name      = "v"

  initial_password {
    value     = "a"
    temporary = true
  }
}

resource "keycloak_user_groups" "jozef" {
  realm_id = keycloak_realm.prod.id
  user_id  = keycloak_user.jozef["prod"].id

  group_ids = [
    keycloak_group.grafana_admins.id,
    keycloak_group.realm_admins["prod"].id,
  ]
}

resource "keycloak_user_groups" "jozef_test" {
  realm_id = keycloak_realm.test.id
  user_id  = keycloak_user.jozef["test"].id

  group_ids = [
    keycloak_group.realm_admins["test"].id,
  ]
}

resource "keycloak_user_roles" "jozef" {
  realm_id = keycloak_realm.prod.id
  user_id  = keycloak_user.jozef["prod"].id

  role_ids = [
    keycloak_role.admin.id,
    keycloak_role.grafana_editor.id,
  ]
}
