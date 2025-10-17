output "key_vault_key_id" {
  description = "The ID of the Key Vault Key for CMK"
  value       = azurerm_key_vault_key.cmk.id
}

output "key_vault_uri" {
  description = "The URI of the Key Vault"
  value       = azurerm_key_vault.kv.vault_uri
}
