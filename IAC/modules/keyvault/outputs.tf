output "key_vault_id" {
  value       = azurerm_key_vault.kv.id
  description = "ID of the Azure Key Vault"
}

output "key_vault_name" {
  value       = azurerm_key_vault.kv.name
  description = "Name of the Azure Key Vault"
}

output "key_vault_key_id" {
  value       = azurerm_key_vault_key.kv_key.id
  description = "Key Vault Key ID for CMK encryption"
}
