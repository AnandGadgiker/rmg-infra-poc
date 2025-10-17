variable "key_vault_name" {
  type        = string
  description = "Globally unique name for Key Vault"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "sku_name" {
  type        = string
  description = "Key Vault SKU"
  default     = "standard"
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
