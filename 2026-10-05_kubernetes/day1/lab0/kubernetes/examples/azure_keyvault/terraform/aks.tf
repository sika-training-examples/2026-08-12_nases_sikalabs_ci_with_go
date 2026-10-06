data "azurerm_kubernetes_cluster" "aks" {
  name                = local.external_aks_name
  resource_group_name = local.external_aks_rg
}

resource "azurerm_user_assigned_identity" "kv-reader" {
  name                = "${local.external_aks_name}-kv-reader"
  resource_group_name = local.rg_name
  location            = local.location
}

resource "azurerm_federated_identity_credential" "kv-reader" {
  for_each = toset(local.external_aks_service_accounts)

  name                      = "${local.external_aks_name}-kv-reader-${replace(each.key, ":", "-")}"
  user_assigned_identity_id = azurerm_user_assigned_identity.kv-reader.id

  issuer   = data.azurerm_kubernetes_cluster.aks.oidc_issuer_url
  subject  = "system:serviceaccount:${each.key}"
  audience = ["api://AzureADTokenExchange"]
}

resource "azurerm_role_assignment" "kv-reader_keyvault" {
  principal_id         = azurerm_user_assigned_identity.kv-reader.principal_id
  role_definition_name = "Key Vault Secrets User"
  scope                = azurerm_key_vault.this.id
}

output "client_id" {
  value = azurerm_user_assigned_identity.kv-reader.client_id
}
