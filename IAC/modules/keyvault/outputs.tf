output "key_vault_key_id" {
  value       = azurerm_key_vault_key.cmk.id
  description = "Customer Managed Key ID for other modules"
}

output "key_vault_uri" {
  value       = azurerm_key_vault.kv.vault_uri
  description = "Key Vault URI for other modules"
}

output "key_vault_name" {
  value       = azurerm_key_vault.kv.name
  description = "Key Vault name"
}

output "user_assigned_identity_id" {
  value       = azurerm_user_assigned_identity.uami.id
  description = "Resource ID of the UAMI for CMK"
}
