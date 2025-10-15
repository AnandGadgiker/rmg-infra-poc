module "keyvault" {
  source              = "../../modules/keyvault"
  key_vault_name      = "your-kv-name"
  location            = var.location
  resource_group_name = var.resource_group_name
  tenant_id           = var.tenant_id
  object_id           = var.object_id
}