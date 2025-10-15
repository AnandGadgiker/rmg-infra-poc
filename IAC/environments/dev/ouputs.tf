# Key Vault URI
output "key_vault_uri" {
  value       = module.keyvault.key_vault_id
  description = "The URI of the Dev Key Vault"
}

# Key Vault CMK key ID
output "key_vault_cmk_id" {
  value       = module.keyvault.key_vault_key_id
  description = "The Customer Managed Key (CMK) ID in Key Vault"
}

# Cosmos DB name
output "cosmosdb_name" {
  value       = module.cosmosdb.cosmosdb_name
  description = "The name of the Cosmos DB instance"
}

# ACR name
output "acr_name" {
  value       = module.acr.acr_name
  description = "The name of the Azure Container Registry"
}

# Storage Account name
output "storage_account_name" {
  value       = module.storage_account.storage_account_name
  description = "The name of the Storage Account"
}

# Event Hub namespace
output "eventhub_namespace" {
  value       = module.eventhub.eventhub_namespace
  description = "The Event Hub namespace"
}

# Event Hub name
output "eventhub_name" {
  value       = module.eventhub.eventhub_name
  description = "The Event Hub name"
}
