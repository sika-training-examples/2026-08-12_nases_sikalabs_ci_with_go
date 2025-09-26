resource "slu_random_password" "keycloak" {
  count = 4
}

resource "vault_generic_secret" "keycloak" {
  path = "secret/pss/_platform/keycloak"

  data_json = jsonencode({
    "admin-password" : slu_random_password.keycloak[0].result,
    "management-password" : slu_random_password.keycloak[1].result,
    "postgresAdminPassword" : slu_random_password.keycloak[2].result,
    "postgresPassword" : slu_random_password.keycloak[3].result
  })
}
