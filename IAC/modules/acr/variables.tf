variable "acr_name" {
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
  default = null
}

variable "geo_replication_location" {
  description = "Optional secondary location for geo-replication (must differ from primary location)"
  type        = string
  default     = null
}

variable "tags" {
  description = "Optional tags for the ACR"
  type        = map(string)
  default     = {}
}

