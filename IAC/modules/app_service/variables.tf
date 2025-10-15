variable "app_service_name" {
  type        = string
  description = "Name of the App Service"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "resource_group_name" {
  type        = string
  description = "Resource Group name"
}

variable "app_service_plan_id" {
  type        = string
  description = "ID of the App Service Plan"
}

variable "app_settings" {
  type        = map(string)
  description = "App settings for the App Service"
}

variable "linux_fx_version" {
  type        = string
  default     = "NODE|18-lts"   # Example default, can be overridden
  description = "Linux FX version (runtime stack) for App Service"
}
