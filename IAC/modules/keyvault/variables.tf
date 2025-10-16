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

variable "terraform_sp_object_id" {
  type        = string
  description = "Object ID of the SP or Managed Identity running Terraform"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags to assign to the Key Vault"
}

variable "policy_propagation_delay" {
  type        = number
  default     = 45
  description = "Seconds to wait for Key Vault access policy propagation"
}

variable "env" {
  type = string
}

variable "provider_object_id" {
  type        = string
  description = "Object ID of the provider identity (e.g., Azure App Service, Function App)"
  default     = null
}
