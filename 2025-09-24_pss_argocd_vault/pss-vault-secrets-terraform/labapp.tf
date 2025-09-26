resource "vault_generic_secret" "labapp" {
  path = "secret/apps/labapp"

  data_json = jsonencode({
    username = "zilina"
    password = "bratislava"
  })
}
