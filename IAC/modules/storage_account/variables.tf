variable "storage_account_name" {}
variable "location" {}
variable "resource_group_name" {}
variable "key_vault_key_id" {
  type        = string
  description = "Key Vault Key ID for customer-managed key encryption"
  default     = null
}