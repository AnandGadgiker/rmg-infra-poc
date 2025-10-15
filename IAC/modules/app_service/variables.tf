variable "app_service_plan_name" {
  type        = string
  description = "Name of the App Service Plan"
}

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

variable "app_settings" {
  type        = map(string)
  description = "App Service application settings"
  default     = {}
}

variable "subnet_id" {
  type        = string
  description = "Optional subnet ID for App Service Environment (ASE)"
  default     = null
}
