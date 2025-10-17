# Cosmos DB
output "cosmosdb_name" {
  value       = var.cosmosdb_name
  description = "Cosmos DB account name"
}

# Azure Container Registry
output "acr_name" {
  value       = var.acr_name
  description = "Azure Container Registry name"
}

# Storage Account
output "storage_account_name" {
  value       = var.storage_account_name
  description = "Storage account name"
}

output "storage_account_id" {
  value       = var.storage_account_id
  description = "Resource ID of the storage account"
}

# Event Hub
output "eventhub_namespace" {
  value       = var.eventhub_namespace
  description = "Event Hub namespace"
}

output "eventhub_name" {
  value       = var.eventhub_name
  description = "Event Hub name"
}

# App Service
output "app_service_name" {
  value       = var.app_service_name
  description = "App Service name"
}

output "app_service_default_hostname" {
  value       = var.app_service_default_hostname
  description = "Default hostname of the App Service"
}

# Key Vault
output "key_vault_name" {
  value       = var.key_vault_name
  description = "Key Vault name"
}

output "key_vault_id" {
  value       = var.key_vault_id
  description = "Resource ID of the Key Vault"
}

output "key_vault_key_id" {
  value       = var.key_vault_key_id
  description = "Customer Managed Key ID"
}

output "key_vault_uri" {
  value       = var.key_vault_uri
  description = "The URI of the Key Vault"
}

# User Assigned Managed Identity
output "user_assigned_identity_id" {
  value       = var.user_assigned_identity_id
  description = "Resource ID of the UAMI"
}

output "user_assigned_identity_principal_id" {
  value       = var.user_assigned_identity_principal_id
  description = "Principal ID of the UAMI"
}
