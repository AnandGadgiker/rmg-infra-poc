variable "app_name" {}
variable "location" {}
variable "resource_group_name" {}
variable "container_app_environment_id" {}
variable "image" {}
variable "tags" {
  type    = map(string)
  default = {}
}
variable "log_analytics_workspace_id" {}

resource "azurerm_container_app" "this" {
  name                         = var.app_name
  location                     = var.location
  resource_group_name          = var.resource_group_name
  container_app_environment_id = var.container_app_environment_id
  revision_mode                = "Single"

  template {
    container {
      name   = var.app_name
      image  = var.image
      cpu    = 0.5
      memory = "1.0Gi"
    }
  }

  ingress {
    external_enabled = true
    target_port      = 80
    traffic_weight {
      percentage      = 100
      latest_revision = true
    }
  }

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}

resource "azurerm_monitor_diagnostic_setting" "diag" {
  name                       = "${var.app_name}-diag"
  target_resource_id         = azurerm_container_app.this.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  log {
    category = "ContainerAppConsoleLogs"
    enabled  = true
  }

  metric {
    category = "AllMetrics"
    enabled  = true
  }
}
