variable "acr_name" {
  type        = string
  description = "Name of the Azure Container Registry"
}

variable "location" {
  type        = string
  description = "Azure region for the ACR"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group where ACR will be deployed"
}

variable "key_vault_key_id" {
  type        = string
  description = "ID of the Key Vault key used for ACR encryption"
  default     = null
}