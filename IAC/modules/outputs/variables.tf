# Key Vault
variable "key_vault_name" { type = string }
variable "key_vault_id" { type = string }
variable "key_vault_key_id" { type = string }
variable "key_vault_uri" { type = string }

# UAMI
variable "user_assigned_identity_id" { type = string }
variable "user_assigned_identity_principal_id" { type = string }

# Storage
variable "storage_account_name" { type = string }
variable "storage_account_id" { type = string }

# Cosmos DB
variable "cosmosdb_name" { type = string }

# ACR
variable "acr_name" { type = string }

# Event Hub
variable "eventhub_namespace" { type = string }
variable "eventhub_name" { type = string }

# App Service
variable "app_service_name" { type = string }
variable "app_service_default_hostname" { type = string }
