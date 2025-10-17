output "key_vault_key_id" {
  # Use the versionless ID so Cosmos/Storage/ACR accept it
  value       = azurerm_key_vault_key.cmk.versionless_id
  description = "Versionless Key Vault key ID (safe for Cosmos/Storage/ACR)"
}

output "key_vault_id" {
  value       = azurerm_key_vault.kv.id
  description = "Resource ID of the Key Vault"
}

output "key_vault_uri" {
  value       = azurerm_key_vault.kv.vault_uri
  description = "Vault URI"
}

output "user_assigned_identity_id" {
  value       = azurerm_user_assigned_identity.uami.id
  description = "UAMI resource ID"
}

output "user_assigned_identity_principal_id" {
  value       = azurerm_user_assigned_identity.uami.principal_id
  description = "UAMI principal ID"
}
