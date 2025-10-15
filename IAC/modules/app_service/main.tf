module "kv" {
  source = "../../modules/keyvault"
  key_vault_name = var.key_vault_name
  location = var.location
  resource_group_name = var.resource_group_name
  tenant_id = var.tenant_id
  aad_client_secret_value = var.aad_client_secret_value
}

module "app_svc" {
  source = "../../modules/app_service"
  app_service_plan_name = var.app_service_plan_name
  app_service_name = var.app_service_name
  location = var.location
  resource_group_name = var.resource_group_name
  app_settings = {
    ENV = var.env
    AAD_CLIENT_SECRET = module.kv.aad_client_secret_name
  }
  subnet_id = var.subnet_id
}
