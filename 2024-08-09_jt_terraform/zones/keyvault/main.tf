resource "azurerm_resource_group" "rg" {
  name     = "kv"
  location = "West Europe"
}

data "azurerm_client_config" "current" {}


data "azurerm_linux_web_app" "example" {
  name                = "existing"
  resource_group_name = "existing"
}

resource "azurerm_key_vault" "kv" {
  name                = "osdemojtkv999"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku_name            = "standard"

  tenant_id = data.azurerm_client_config.current.tenant_id

  access_policy {
    object_id = "0fdd1722-661a-4b94-9292-192544017b60"
    secret_permissions = [
      "Get",
      "List",
      "Set",
      "Delete",
      "Recover",
      "Backup",
      "Restore",
      "Purge",
    ]
    tenant_id = "f2d0a0f9-bb6c-4645-80d0-0481dcc90588"
  }

}

# Define a secret in the Key Vault
resource "azurerm_key_vault_secret" "example" {
  name         = "my-secret"
  value        = "my-secret-value"
  key_vault_id = azurerm_key_vault.kv.id
}
