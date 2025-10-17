output "storage_account_id" {
  value       = azurerm_storage_account.storage.id
  description = "Resource ID of the storage account"
}

output "storage_account_name" {
  value       = azurerm_storage_account.storage.name
  description = "Name of the storage account"
}

output "primary_blob_endpoint" {
  value       = azurerm_storage_account.storage.primary_blob_endpoint
  description = "Primary blob endpoint URL"
}
