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
