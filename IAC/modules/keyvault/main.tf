# Key Vault
resource "azurerm_key_vault" "kv" {
  name                     = var.key_vault_name
  location                 = var.location
  resource_group_name      = var.resource_group_name
  tenant_id                = var.tenant_id
  sku_name                 = "standard"
  purge_protection_enabled = true
}

# AAD Client Secret
resource "azurerm_key_vault_secret" "aad_client_secret" {
  name         = "aad-client-secret"
  value        = var.aad_client_secret_value
  key_vault_id = azurerm_key_vault.kv.id
}

# Customer Managed Key (CMK) for other resources
resource "azurerm_key_vault_key" "cmk" {
  name         = "cmk-key"                # Give a meaningful name
  key_vault_id = azurerm_key_vault.kv.id
  key_type     = "RSA"
  key_size     = 2048
}

# Outputs
output "key_vault_id" {
  value = azurerm_key_vault.kv.id
}

output "aad_client_secret_name" {
  value = azurerm_key_vault_secret.aad_client_secret.name
}

output "key_vault_key_id" {
  value       = azurerm_key_vault_key.cmk.id
  description = "The ID of the Key Vault Key for customer-managed keys"
}
