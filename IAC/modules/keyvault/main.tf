resource "azurerm_key_vault" "kv" {
  name                        = var.key_vault_name
  location                    = var.location
  resource_group_name         = var.resource_group_name
  tenant_id                   = var.tenant_id
  sku_name                    = "standard"
  purge_protection_enabled    = true
}

resource "azurerm_key_vault_secret" "aad_client_secret" {
  name         = "aad-client-secret"
  value        = var.aad_client_secret_value
  key_vault_id = azurerm_key_vault.kv.id
}

output "key_vault_id" {
  value = azurerm_key_vault.kv.id
}

output "aad_client_secret_name" {
  value = azurerm_key_vault_secret.aad_client_secret.name
}
