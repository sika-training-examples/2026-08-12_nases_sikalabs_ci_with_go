# The Terraform principal needs Secrets Officer to be able to create secrets below
resource "azurerm_role_assignment" "terraform" {
  scope                = azurerm_key_vault.this.id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = data.azurerm_client_config.current.object_id
}

resource "azurerm_key_vault_secret" "secrets" {
  for_each   = local.secrets
  depends_on = [azurerm_role_assignment.terraform]

  key_vault_id = azurerm_key_vault.this.id

  name  = each.key
  value = each.value
}
