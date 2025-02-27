locals {
  users = {
    dela = [
      "Dela", "Dela", "IT",
      [
        keycloak_group.realm1-admins.id,
      ],
      [
        keycloak_role.realm1-admin.id,
        keycloak_role.realm1-user.id,
        keycloak_role.realm1-editor.id,
        keycloak_role.realm1-viewer.id,
      ]
    ]
    nela = [
      "Nela", "Nela", "HR",
      [
        keycloak_group.realm1-viewers.id,
      ],
      [
        keycloak_role.realm1-user.id,
        keycloak_role.realm1-viewer.id,
      ]
    ]
  }
}

resource "keycloak_user" "users1" {
  lifecycle {
    ignore_changes = [
      required_actions,
    ]
  }

  for_each = local.users

  realm_id = keycloak_realm.realm1.id
  username = each.key
  enabled  = true

  email          = "${each.key}@example.com"
  email_verified = true
  first_name     = each.value[0]
  last_name      = each.value[1]

  attributes = {
    department = each.value[2]
  }

  initial_password {
    value     = "a"
    temporary = false
  }
}

resource "keycloak_user_groups" "users" {
  for_each = local.users

  realm_id = keycloak_realm.realm1.id
  user_id  = keycloak_user.users1[each.key].id

  group_ids = each.value[3]
}

resource "keycloak_user_roles" "users" {
  for_each = local.users

  realm_id = keycloak_realm.realm1.id
  user_id  = keycloak_user.users1[each.key].id

  role_ids = each.value[4]
}
