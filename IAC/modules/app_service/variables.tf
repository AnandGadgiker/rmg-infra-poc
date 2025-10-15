variable "app_service_plan_name" {
  type = string
}

variable "app_service_name" {
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

variable "kind" {
  type    = string
  default = "Linux"  # "Linux" or "App"
}

variable "sku_tier" {
  type    = string
  default = "P1v2"
}

variable "sku_size" {
  type    = string
  default = "P1v2"
}

variable "app_settings" {
  type    = map(string)
  default = {}
}

variable "storage_account_name" {
  type    = string
  default = null
}

variable "key_vault_name" {
  type    = string
  default = null
}

variable "key_vault_key_id" {
  type    = string
  default = null
}

