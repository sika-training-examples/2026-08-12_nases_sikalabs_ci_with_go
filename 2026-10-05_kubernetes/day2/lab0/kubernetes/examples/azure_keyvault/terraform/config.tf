locals {
  external_aks_name = "training"
  external_aks_rg   = "training_group"
  external_aks_service_accounts = [
    "keyvault-demo:kv-reader",
  ]

  location      = "germanywestcentral"
  rg_name       = "aks-keyvault-example-rg"
  keyvault_name = "aks-kv-example-260514"

  secrets = {
    "secret1"             = "value1aaa"
    "secret2"             = "value2bbb"
    "EXAMPLE-DB-USERNAME" = "secret_username"
    "EXAMPLE-DB-PASSWORD" = "secret_password"
  }
}
