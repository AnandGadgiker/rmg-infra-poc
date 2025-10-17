variable "cosmosdb_name" {
  type        = string
  description = "Cosmos DB account name"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "key_vault_key_id" {
  type        = string
  description = "Key Vault CMK ID for encryption at rest"
}
