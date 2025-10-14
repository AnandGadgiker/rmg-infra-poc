terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

locals {
  prefix = var.prefix
  tags   = merge({ environment = var.environment }, var.tags)
}

module "rg" {
  source   = "../../modules/resource_group"
  rg_name  = "${local.prefix}-${var.environment}-rg"
  location = var.location
  tags     = local.tags
}

module "storage_account" {
  source              = "../../modules/storage_account"
  name_prefix         = local.prefix
  location            = var.location
  resource_group_name = module.rg.id
  tags                = local.tags
}

module "acr" {
  source              = "../../modules/acr"
  name_prefix         = local.prefix
  location            = var.location
  resource_group_name = module.rg.id
  tags                = local.tags
}

module "cosmosdb" {
  source              = "../../modules/cosmosdb"
  name_prefix         = local.prefix
  location            = var.location
  resource_group_name = module.rg.id
  tags                = local.tags
}

module "app_service" {
  source              = "../../modules/app_service"
  name_prefix         = local.prefix
  location            = var.location
  resource_group_name = module.rg.id
  tags                = local.tags
  app_count           = 2
}

module "eventhub" {
  source              = "../../modules/eventhub"
  name_prefix         = local.prefix
  location            = var.location
  resource_group_name = module.rg.id
  tags                = local.tags
}
