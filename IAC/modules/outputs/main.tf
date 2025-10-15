output "key_vault_uri" {
  value       = var.keyvault_id
  description = "The URI of the Key Vault"
}

output "key_vault_cmk_id" {
  value       = var.keyvault_cmk_id
  description = "The Customer Managed Key (CMK) ID"
}

output "cosmosdb_name" {
  value       = var.cosmosdb_name
  description = "The name of the Cosmos DB instance"
}

output "acr_name" {
  value       = var.acr_name
  description = "The name of the Azure Container Registry"
}

output "storage_account_name" {
  value       = var.storage_account_name
  description = "The name of the Storage Account"
}

output "eventhub_namespace" {
  value       = var.eventhub_namespace
  description = "The Event Hub namespace"
}

output "eventhub_name" {
  value       = var.eventhub_name
  description = "The Event Hub name"
}
