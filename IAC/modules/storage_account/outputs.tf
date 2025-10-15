output "storage_account_name" {
  value       = azurerm_storage_account.sa.name
  description = "Name of the Storage Account"
}

output "storage_account_id" {
  value       = azurerm_storage_account.sa.id
  description = "ID of the Storage Account"
}
