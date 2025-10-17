output "key_vault_key_id" {
  value = azurerm_key_vault_key.cmk.id
}

output "user_assigned_identity_id" {
  value = azurerm_user_assigned_identity.uami.id
}

output "user_assigned_identity_principal_id" {
  value = azurerm_user_assigned_identity.uami.principal_id
}

output "key_vault_id" {
  value = azurerm_key_vault.kv.id
}

output "key_vault_uri" {
  value = azurerm_key_vault.kv.vault_uri
}
