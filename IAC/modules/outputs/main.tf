# Key Vault
output "key_vault_name" { value = var.key_vault_name }
output "key_vault_id" { value = var.key_vault_id }
output "key_vault_key_id" { value = var.key_vault_key_id }
output "key_vault_uri" { value = var.key_vault_uri }

# UAMI
output "user_assigned_identity_id" {
  value = var.user_assigned_identity_id
}
output "user_assigned_identity_principal_id" {
  value = var.user_assigned_identity_principal_id
}

# Storage
output "storage_account_name" { value = var.storage_account_name }
output "storage_account_id" { value = var.storage_account_id }

# Cosmos DB
output "cosmosdb_name" { value = var.cosmosdb_name }

# ACR
output "acr_name" { value = var.acr_name }

# Event Hub
output "eventhub_namespace" { value = var.eventhub_namespace }
output "eventhub_name" { value = var.eventhub_name }

# App Service
output "app_service_name" { value = var.app_service_name }
output "app_service_default_hostname" { value = var.app_service_default_hostname }
