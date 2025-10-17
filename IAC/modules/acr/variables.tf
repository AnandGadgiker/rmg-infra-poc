variable "acr_name" {
  type        = string
  description = "ACR name"
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

variable "geo_replication_location" {
  type        = string
  description = "Secondary region for ACR geo-replication"
  default     = null
}
