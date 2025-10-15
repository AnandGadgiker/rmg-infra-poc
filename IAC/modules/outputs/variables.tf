variable "keyvault_id" {
  type        = string
  description = "The Key Vault resource ID"
}

variable "keyvault_cmk_id" {
  type        = string
  description = "The Customer Managed Key (CMK) ID"
}

variable "cosmosdb_name" {
  type        = string
  description = "The Cosmos DB instance name"
}

variable "acr_name" {
  type        = string
  description = "The Azure Container Registry name"
}

variable "storage_account_name" {
  type        = string
  description = "The Storage Account name"
}

variable "eventhub_namespace" {
  type        = string
  description = "The Event Hub namespace"
}

variable "eventhub_name" {
  type        = string
  description = "The Event Hub name"
}
