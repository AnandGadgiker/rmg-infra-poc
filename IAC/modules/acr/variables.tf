variable "acr_name" {}
variable "location" {}
variable "resource_group_name" {}
variable "key_vault_key_id" {
  type        = string
  description = "ID of the Key Vault key used for ACR encryption"
}