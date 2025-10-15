
variable "app_service_plan_name" {
  description = "Name of the App Service Plan"
  type        = string
}

variable "app_service_name" {
  description = "Name of the App Service"
  type        = string
}

variable "location" {
  description = "Azure region for deployment"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "app_settings" {
  description = "Application settings for the App Service"
  type        = map(string)
}

variable "subnet_id" {
  description = "Subnet ID for VNet integration"
  type        = string
}

variable "app_service_plan_id" {
  description = "ID of the App Service Plan"
  type        = string
}

variable "auth_issuer_url" {
  description = "Issuer URL for App Service authentication"
  type        = string
  default     = null
}

variable "auth_client_id" {
  description = "Client ID for Azure AD authentication"
  type        = string
  default     = null
}

variable "auth_client_secret" {
  description = "Client secret for Azure AD authentication"
  type        = string
  default     = null
}

variable "storage_account_name" {
  description = "Storage account name for mounting"
  type        = string
  default     = null
}

variable "storage_account_access_key" {
  description = "Access key for the storage account"
  type        = string
  default     = null
}

variable "storage_share_name" {
  description = "Name of the file share to mount"
  type        = string
  default     = null
}
