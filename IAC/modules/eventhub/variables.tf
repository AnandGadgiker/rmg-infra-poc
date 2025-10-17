variable "eventhub_namespace" {
  type        = string
  description = "Event Hub namespace name"
}

variable "eventhub_name" {
  type        = string
  description = "Event Hub name"
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
  description = "Subnet resource ID for private endpoints or integration"
}
