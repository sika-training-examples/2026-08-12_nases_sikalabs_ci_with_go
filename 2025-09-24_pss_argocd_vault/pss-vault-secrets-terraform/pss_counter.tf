resource "slu_random_password" "project_counter_mongodb_dev" {}

resource "vault_generic_secret" "project_counter_mongodb_dev" {
  path = "secret/pss/project_counter/dev/mongodb_root_password"

  data_json = jsonencode({
    "MONGODB_ROOT_PASSWORD" : slu_random_password.project_counter_mongodb_dev.result,
  })
}

resource "vault_generic_secret" "project_counter_be_env_dev" {
  path = "secret/pss/project_counter/dev/be-env"

  data_json = jsonencode({
    "MONGODB_URI" : "mongodb://root:${slu_random_password.project_counter_mongodb_dev.result}@pss-counter-dev-mongo:27017/",
  })
}


resource "slu_random_password" "project_counter_mongodb_prod" {}

resource "vault_generic_secret" "project_counter_mongodb_prod" {
  path = "secret/pss/project_counter/prod/mongodb_root_password"

  data_json = jsonencode({
    "MONGODB_ROOT_PASSWORD" : slu_random_password.project_counter_mongodb_prod.result,
  })
}

resource "vault_generic_secret" "project_counter_be_env_prod" {
  path = "secret/pss/project_counter/prod/be-env"

  data_json = jsonencode({
    "MONGODB_URI" : "mongodb://root:${slu_random_password.project_counter_mongodb_prod.result}@pss-counter-prod-mongo:27017/",
  })
}
