# Key Vault
output "key_vault_id" {
  description = "ID of the Azure Key Vault"
  value       = var.keyvault_id
}

# CosmosDB
output "cosmosdb_name" {
  description = "Name of the CosmosDB account"
  value       = var.cosmosdb_name
}

# Azure Container Registry
output "acr_name" {
  description = "Name of the Azure Container Registry"
  value       = var.acr_name
}

# Storage Account
output "storage_account_name" {
  description = "Name of the Storage Account"
  value       = var.storage_account_name
}

# EventHub
output "eventhub_namespace" {
  description = "EventHub namespace"
  value       = var.eventhub_namespace
}

output "eventhub_name" {
  description = "EventHub name"
  value       = var.eventhub_name
}

# App Service
output "app_service_name" {
  description = "Name of the App Service"
  value       = var.app_service_name
}

output "app_service_default_hostname" {
  description = "Default hostname of the App Service"
  value       = var.app_service_default_hostname
}
