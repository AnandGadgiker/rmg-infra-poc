variable "storage_account_name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "subnet_id" {
  type    = string
  default = null
}

variable "key_vault_name" {
  type    = string
  default = null
}

variable "user_assigned_identity_id" {
  type    = string
  default = null
}

variable "key_vault_key_id" {
  type    = string
  default = null
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags to assign to the Storage Account"
}

variable "env" {
  type = string
}

variable "terraform_sp_object_id" {
  type        = string
  description = "Object ID of the SP or Managed Identity running Terraform"
}

variable "provider_object_id" {
  description = "Object ID of the identity used by the Terraform Azure Provider (used for reading existing secrets/keys)"
  type        = string
  default     = null
}