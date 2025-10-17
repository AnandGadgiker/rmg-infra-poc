variable "storage_account_name" {
  type        = string
  description = "Name of the Storage Account"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the Resource Group"
}

variable "subnet_id" {
  type        = string
  default     = null
  description = "Optional subnet ID for private endpoint integration"
}

variable "key_vault_key_id" {
  type        = string
  description = "Resource ID of the Key Vault key used for CMK"
}

variable "user_assigned_identity_id" {
  type        = string
  description = "Resource ID of the User Assigned Managed Identity used for CMK"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags to assign to the Storage Account"
}

variable "env" {
  type        = string
  description = "Environment name (e.g. dev, uat, prod)"
}

variable "terraform_sp_object_id" {
  type        = string
  description = "Object ID of the SP or Managed Identity running Terraform"
}
