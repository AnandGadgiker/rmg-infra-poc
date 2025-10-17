variable "storage_account_name" {
  type        = string
  description = "Globally unique storage account name"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "env" {
  type        = string
  description = "Environment label (dev/uat/prod)"
}

variable "tags" {
  type        = map(string)
  description = "Common resource tags"
  default     = {}
}

variable "key_vault_key_id" {
  type        = string
  description = "Key Vault CMK ID used for encryption"
}

variable "user_assigned_identity_id" {
  type        = string
  description = "Resource ID of the UAMI bound to the storage account"
}
