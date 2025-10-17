output "key_vault_id" {
  value       = azurerm_key_vault.kv.id
  description = "ID of the Key Vault"
}

output "key_vault_uri" {
  value       = azurerm_key_vault.kv.vault_uri
  description = "URI of the Key Vault"
}

output "key_vault_key_id" {
  value       = azurerm_key_vault_key.cmk.id
  description = "ID of the Key Vault Key (Customer Managed Key)"
}
