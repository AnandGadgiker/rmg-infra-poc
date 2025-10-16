variable "key_vault_name" {
  type        = string
  description = "Name of the Key Vault"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the Resource Group"
}

variable "tenant_id" {
  type        = string
  description = "Azure AD tenant ID"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags to assign to the Key Vault"
}
