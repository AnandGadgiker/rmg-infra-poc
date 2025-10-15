
resource "azurerm_app_service" "app" {
  name                = var.app_service_name
  location            = var.location
  resource_group_name = var.resource_group_name
  app_service_plan_id = azurerm_app_service_plan.plan.id
  virtual_network_subnet_id = var.subnet_id
  app_service_plan_id = var.app_service_plan_id

  identity {
    type = "SystemAssigned"
  }

  site_config {
    scm_type                        = "LocalGit"
    vnet_route_all_enabled          = true
    ftps_state                      = "Disabled"
    detailed_error_messages_enabled = true
    http_logging_enabled            = true
    failed_request_tracing_enabled = true
    http2_enabled                   = true
    min_tls_version                 = "1.2"
    redirect_http_to_https          = true
    client_cert_enabled             = true
    use_32_bit_worker_process       = false
    websockets_enabled              = true
    remote_debugging_enabled        = false
    remote_debugging_version        = "VS2019"
    health_check_path               = "/health"
    app_command_line                = ""
    default_documents               = ["index.html"]
  }

  app_settings = var.app_settings

  auth_settings {
    enabled          = true
    default_provider = "AzureActiveDirectory"
    issuer           = var.auth_issuer_url
    client_id        = var.auth_client_id
    client_secret    = var.auth_client_secret
  }

  storage_account {
    name         = var.storage_account_name
    access_key   = var.storage_account_access_key
    mount_path   = "/mnt/data"
    share_name   = var.storage_share_name
    type         = "AzureFiles"
  }
}
