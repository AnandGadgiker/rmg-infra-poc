terraform {
  required_version = ">= 1.5.7"
}

# Load variables from dev.tfvars automatically via GitHub Actions
variable "location" {}
variable "resource_group_name" {}
variable "key_vault_name" {}
variable "app_service_plan_name" {}
variable "app_service_name" {}
variable "app_settings" {}
variable "cosmosdb_name" {}
variable "acr_name" {}
variable "storage_account_name" {}
variable "eventhub_namespace" {}
variable "eventhub_name" {}
variable "subnet_id" {}
variable "auth_client_id" {}
variable "auth_client_secret" {}
variable "auth_issuer_url" {}

# --------------------------
# Key Vault
# --------------------------
module "keyvault" {
  source                = "../../modules/keyvault"
  key_vault_name        = var.key_vault_name
  location              = var.location
  resource_group_name   = var.resource_group_name
  tenant_id             = var.auth_client_id
  object_id             = var.auth_client_id
}

# --------------------------
# App Service Plan
# --------------------------
resource "azurerm_app_service_plan" "app_service_plan" {
  name                = var.app_service_plan_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku {
    tier = "Standard"
    size = "S1"
  }
}

# --------------------------
# App Service
# --------------------------
module "app_service" {
  source                = "../../modules/app_service"
  app_service_plan_id   = azurerm_app_service_plan.app_service_plan.id
  app_service_plan_name = var.app_service_plan_name
  app_service_name      = var.app_service_name
  location              = var.location
  resource_group_name   = var.resource_group_name
  app_settings          = var.app_settings
  subnet_id             = var.subnet_id
  key_vault_id          = module.keyvault.key_vault_id
}

# --------------------------
# CosmosDB
# --------------------------
module "cosmosdb" {
  source              = "../../modules/cosmosdb"
  cosmosdb_name       = var.cosmosdb_name
  location            = var.location
  resource_group_name = var.resource_group_name
  key_vault_id        = module.keyvault.key_vault_id
}

# --------------------------
# Azure Container Registry
# --------------------------
module "acr" {
  source              = "../../modules/acr"
  acr_name            = var.acr_name
  location            = var.location
  resource_group_name = var.resource_group_name
  key_vault_id        = module.keyvault.key_vault_id
}

# --------------------------
# Storage Account
# --------------------------
module "storage_account" {
  source                = "../../modules/storage_account"
  storage_account_name  = var.storage_account_name
  location              = var.location
  resource_group_name   = var.resource_group_name
  key_vault_id          = module.keyvault.key_vault_id
}

# --------------------------
# EventHub
# --------------------------
module "eventhub" {
  source              = "../../modules/eventhub"
  eventhub_namespace  = var.eventhub_namespace
  eventhub_name       = var.eventhub_name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id
}

# --------------------------
# Outputs
# --------------------------
module "dev_outputs" {
  source                      = "../../modules/outputs"
  keyvault_id                 = module.keyvault.key_vault_id
  cosmosdb_name               = module.cosmosdb.cosmosdb_name
  acr_name                    = module.acr.acr_name
  storage_account_name        = module.storage_account.storage_account_name
  eventhub_namespace          = module.eventhub.eventhub_namespace
  eventhub_name               = module.eventhub.eventhub_name
  app_service_name            = module.app_service.app_service_name
  app_service_default_hostname= module.app_service.app_service_default_hostname
}
