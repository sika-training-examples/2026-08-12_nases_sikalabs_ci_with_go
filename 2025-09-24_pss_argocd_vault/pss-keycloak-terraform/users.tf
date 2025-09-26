locals {
  users = [
    ["ondrej", "ondrej@sika.io", "Ondrej", "Sika", local.admins, local.admin_roles],
    ["pss", "pss@pss.sk", "pss", "pss", local.admins, local.admin_roles],
    ["dev", "dev@pss.sk", "Dev", "Dev", [keycloak_group.hello_pss_dev.id], []],
    ["prod", "prod@pss.sk", "Prod", "Prod", [keycloak_group.hello_pss_prod.id], []],
  ]
  admins = [
    keycloak_group.argocd_admins.id,
    keycloak_group.vault_admins.id,
  ]
  admin_roles = []
}

resource "slu_random_password" "initial_passwords" {
  for_each = { for user in local.users : user[0] => user }
}

resource "keycloak_user" "users" {
  for_each = { for user in local.users : user[0] => user }

  lifecycle {
    ignore_changes = [
      required_actions,
    ]
  }

  realm_id       = keycloak_realm.pss.id
  username       = each.value[0]
  enabled        = true
  email          = each.value[1]
  email_verified = true
  first_name     = each.value[2]
  last_name      = each.value[3]
  initial_password {
    value     = slu_random_password.initial_passwords[each.key].result
    temporary = true
  }
}

resource "keycloak_user_groups" "users" {
  for_each = { for user in local.users : user[0] => user[4] }

  realm_id  = keycloak_realm.pss.id
  user_id   = keycloak_user.users[each.key].id
  group_ids = each.value
}

resource "keycloak_user_roles" "users" {
  for_each = { for user in local.users : user[0] => user[5] }

  realm_id = keycloak_realm.pss.id
  user_id  = keycloak_user.users[each.key].id
  role_ids = each.value
}

output "initial_passwords" {
  value = {
    for user in local.users :
    user[0] => slu_random_password.initial_passwords[user[0]].result
  }
  sensitive = true
}
