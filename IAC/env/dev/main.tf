terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.100.0" 
    }
  }

  required_version = ">= 1.5.0"
}

provider "azurerm" {
  features {}
}

# Key Vault
module "kv" {
  source                = "../../modules/keyvault"
  key_vault_name        = var.key_vault_name
  location              = var.location
  resource_group_name   = var.resource_group_name
  tenant_id             = var.tenant_id
  aad_client_secret_value = var.aad_client_secret_value
}

# App Service Plan + App Service
module "app_service" {
  source                = "../../modules/app_service"
  app_service_plan_name = var.app_service_plan_name
  app_service_name      = var.app_service_name
  location              = var.location
  resource_group_name   = var.resource_group_name
  app_settings = {
    ENV               = var.env
    AAD_CLIENT_SECRET = module.kv.aad_client_secret_name
  }
  subnet_id = var.subnet_id
}

# Cosmos DB
module "cosmos" {
  source              = "../../modules/cosmosdb"
  cosmosdb_name       = var.cosmosdb_name
  location            = var.location
  resource_group_name = var.resource_group_name
  key_vault_key_id    = module.kv.key_vault_key_id
}

# Azure Container Registry
module "acr" {
  source              = "../../modules/acr"
  acr_name            = var.acr_name
  location            = var.location
  resource_group_name = var.resource_group_name
  key_vault_key_id   = module.kv.key_vault_key_id
}

# Storage Account
module "stg" {
  source               = "../../modules/storage_account"
  storage_account_name = var.storage_account_name
  location             = var.location
  resource_group_name  = var.resource_group_name
  key_vault_key_id     = module.kv.key_vault_key_id
  subnet_id            = var.subnet_id
}

# Event Hub
module "eh" {
  source              = "../../modules/eventhub"
  eventhub_namespace  = var.eventhub_namespace
  eventhub_name       = var.eventhub_name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id
}

# Outputs
module "dev_outputs" {
  source                      = "../../modules/outputs"
  key_vault_name               = var.key_vault_name
  key_vault_key_id               = module.kv.key_vault_key_id
  cosmosdb_name                = var.cosmosdb_name
  acr_name                     = var.acr_name
  storage_account_name         = var.storage_account_name
  eventhub_namespace           = var.eventhub_namespace
  eventhub_name                = var.eventhub_name
  app_service_name             = var.app_service_name
  app_service_default_hostname = "${var.app_service_name}.azurewebsites.net"
}
