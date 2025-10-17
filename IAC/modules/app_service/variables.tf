variable "app_service_plan_name" {
  type        = string
  description = "App Service plan name"
}

variable "app_service_name" {
  type        = string
  description = "App Service name"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "subnet_id" {
  type        = string
  description = "Subnet resource ID for integration"
}

variable "app_settings" {
  type        = map(string)
  description = "Key-value app settings"
  default     = {}
}

variable "aad_client_secret_value" {
  type        = string
  description = "Secret value injected into App Settings"
  sensitive   = true
}
