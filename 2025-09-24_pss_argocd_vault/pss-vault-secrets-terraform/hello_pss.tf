resource "vault_generic_secret" "hello_pss_dev" {
  path = "secret/pss/hello_pss_dev/env"

  data_json = jsonencode({
    "COLOR" : "blue",
  })
}

resource "vault_generic_secret" "hello_pss_prod" {
  path = "secret/pss/hello_pss_prod/env"

  data_json = jsonencode({
    "COLOR" : "green",
  })
}
