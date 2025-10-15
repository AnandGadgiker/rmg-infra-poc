output "key_vault_key_id" {
  value       = azurerm_key_vault_key.kv_key.id
  description = "The ID of the Key Vault Key for CMK"
}

output "cosmosdb_name" {
  value = var.cosmosdb_name
}

output "acr_name" {
  value = var.acr_name
}

output "storage_account_name" {
  value = var.storage_account_name
}

output "eventhub_namespace" {
  value = var.eventhub_namespace
}

output "eventhub_name" {
  value = var.eventhub_name
}

output "app_service_name" {
  value = var.app_service_name
}

output "app_service_default_hostname" {
  value = var.app_service_default_hostname
}

