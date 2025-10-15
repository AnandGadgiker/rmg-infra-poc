resource "azurerm_linux_web_app" "app" {
  name                = var.app_service_name
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id     = var.app_service_plan_id
  virtual_network_subnet_id = var.subnet_id

  identity {
    type = "SystemAssigned"
  }

  site_config {
    scm_type               = "LocalGit"
    vnet_route_all_enabled = true
    ftps_state             = "Disabled"
    http2_enabled          = true
    websockets_enabled     = true
    health_check_path      = "/health"
    app_command_line       = ""
    default_documents      = ["index.html"]
  }

  app_settings = var.app_settings

  auth_settings_v2 {
    auth_enabled           = true
    require_authentication = true
    unauthenticated_action = "RedirectToLoginPage"

    active_directory {
      client_id     = var.auth_client_id
      client_secret_setting_name = "AAD_CLIENT_SECRET"
      issuer        = var.auth_issuer_url
    }

    login {
      token_store_enabled = true
    }
  }

  storage_account {
    access_key   = var.storage_account_access_key
    account_name = var.storage_account_name
    share_name   = var.storage_share_name
    mount_path   = "/mnt/data"
    type         = "AzureFiles"
  }
}