module "openai" {
  source              = "../../modules/openai"
  name                = "rmg-openai-dev"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = var.openai_sku
  subnet_id           = var.subnet_id
}