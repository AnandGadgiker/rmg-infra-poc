variable "cosmosdb_name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "key_vault_name" {
  type    = string
  default = null
}

variable "key_vault_key_id" {
  type    = string
  default = null # optional if CMK not used
}