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

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags to assign to the Key Vault"
}

variable "terraform_sp_object_id" {
  type        = string
  description = "Object ID of the SP running Terraform"
}

variable "provider_object_id" {
  type        = string
  default     = null
  description = "Optional object ID of provider identity requiring Key Vault access"
}

variable "sku_name" {
  description = "SKU name of the Key Vault (e.g. standard or premium)"
  type        = string
  default     = "standard"
}

variable "policy_propagation_delay" {
  type        = number
  default     = 45
  description = "Seconds to wait for Key Vault access policy propagation"
}
