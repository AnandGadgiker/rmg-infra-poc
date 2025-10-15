variable "app_service_plan_name" {}
variable "app_service_name" {}
variable "location" {}
variable "resource_group_name" {}
variable "app_settings" {
  type = map(string)
}
variable "subnet_id" {}
variable "app_service_plan_id" {
  type        = string
  description = "ID of the App Service Plan"
}

variable "auth_issuer_url" {
  type        = string
  description = "Issuer URL for App Service authentication"
  default     = null
}

variable "storage_account_name" {
  type        = string
  description = "Storage account name for mounting"
  default     = null
}

variable "storage_account_access_key" {
  type        = string
  description = "Access key for the storage account"
  default     = null
}

variable "storage_share_name" {
  type        = string
  description = "Name of the file share to mount"
  default     = null
}

variable "auth_client_id" {
  type        = string
  description = "Client ID for Azure AD authentication"
  default     = null
}

variable "auth_client_secret" {
  type        = string
  description = "Client secret for Azure AD authentication"
  default     = null
}
