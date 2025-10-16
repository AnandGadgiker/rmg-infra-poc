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

variable "aad_client_secret_value" {
  type        = string
  description = "Value for AAD client secret to store in Key Vault"
}

variable "terraform_sp_object_id" {
  type        = string
  description = "Object ID of the SP or Managed Identity used by Terraform"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags to assign to the Key Vault"
}
