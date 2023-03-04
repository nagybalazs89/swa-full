resource "azurerm_log_analytics_workspace" "example" {
  name                = "acctest-01"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_container_app_environment" "example" {
  name                       = "Example-Environment"
  location                   = azurerm_resource_group.this.location
  resource_group_name        = azurerm_resource_group.this.name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.example.id
}

resource "azurerm_container_app" "example" {
  name                         = "example-app"
  container_app_environment_id = azurerm_container_app_environment.example.id
  resource_group_name          = azurerm_resource_group.this.name
  revision_mode                = "Single"

  template {
    container {
        name   = "examplecontainerapp"
        image  = "bazsibazsi/swa-be:5"
        cpu    = 0.25
        memory = "0.5Gi"
        env {
            name    = "ENV"
            value   = "Sandbox"
        }
    }
  }

  ingress {
    allow_insecure_connections = false
    external_enabled = true
    target_port = 80
    traffic_weight {
        percentage = 100
        latest_revision = true
    }
  }

  timeouts {
    create = "60m"
  }
}