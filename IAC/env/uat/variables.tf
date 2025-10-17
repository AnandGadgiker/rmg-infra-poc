variable "env" {
  description = "Environment name (e.g. dev, uat, prod)"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "key_vault_name" {
  description = "Key Vault name"
  type        = string
}

variable "storage_account_name" {
  description = "Storage Account name"
  type        = string
}

variable "cosmosdb_name" {
  description = "Cosmos DB account name"
  type        = string
}

variable "eventhub_namespace" {
  description = "Event Hub namespace"
  type        = string
}

variable "eventhub_name" {
  description = "Event Hub name"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for Event Hub or Container Apps networking"
  type        = string
}

variable "tags" {
  description = "Common tags applied to all resources"
  type        = map(string)
  default     = {}
}

# -------------------------------
# New: ACRs (3 registries)
# -------------------------------
variable "acr_names" {
  description = "List of ACR names (e.g. acr1dev, acr2dev, acr3dev)"
  type        = list(string)
}

# -------------------------------
# New: Container Apps (3 apps)
# -------------------------------
variable "container_app_names" {
  description = "List of Container App names (e.g. app1-dev, app2-dev, app3-dev)"
  type        = list(string)
}

# Optional: Diagnostic categories (if you want to customize)
variable "enable_container_logs" {
  description = "Enable ContainerAppConsoleLogs diagnostics"
  type        = bool
  default     = true
}

variable "enable_container_metrics" {
  description = "Enable AllMetrics diagnostics"
  type        = bool
  default     = true
}
