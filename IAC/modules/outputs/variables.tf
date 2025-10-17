# Key Vault
variable "key_vault_name" {
  type        = string
  description = "Key Vault name"
}

variable "key_vault_id" {
  type        = string
  description = "Resource ID of the Key Vault"
}

variable "key_vault_key_id" {
  type        = string
  description = "Customer Managed Key ID"
}

variable "key_vault_uri" {
  type        = string
  description = "Key Vault URI"
}

# User Assigned Managed Identity
variable "user_assigned_identity_id" {
  type        = string
  description = "Resource ID of the UAMI"
}

variable "user_assigned_identity_principal_id" {
  type        = string
  description = "Principal ID of the UAMI"
}

# Storage Account
variable "storage_account_name" {
  type        = string
  description = "Storage account name"
}

variable "storage_account_id" {
  type        = string
  description = "Resource ID of the storage account"
}

# Cosmos DB
variable "cosmosdb_name" {
  type        = string
  description = "Cosmos DB account name"
}

# Azure Container Registry
variable "acr_name" {
  type        = string
  description = "Azure Container Registry name"
}

# Event Hub
variable "eventhub_namespace" {
  type        = string
  description = "Event Hub namespace"
}

variable "eventhub_name" {
  type        = string
  description = "Event Hub name"
}

# App Service
variable "app_service_name" {
  type        = string
  description = "App Service name"
}

variable "app_service_default_hostname" {
  type        = string
  description = "Default hostname of the App Service"
}
