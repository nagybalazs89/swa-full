data "azurerm_resource_group" "this" {
  name                          = var.resource_group_name
}

data "azurerm_container_app_environment" "this" {
  name                          = var.container_app_environment_name
  resource_group_name           = data.azurerm_resource_group.this.name
}

resource "azurerm_container_app" "this" {
  name                          = "${var.prefix}-swa-react-be"
  container_app_environment_id  = data.azurerm_container_app_environment.this.id
  resource_group_name           = data.azurerm_resource_group.this.name
  revision_mode                 = "Single"

  template {
    container {
        name                    = "${var.prefix}-swa-react-be"
        image                   = var.image
        cpu                     = var.cpu
        memory                  = var.memory
        dynamic "env" {
          for_each              = var.env 
          content {
            name                = env.key
            value               = env.value
          }
        }
    }
  }

  ingress {
    allow_insecure_connections  = false
    external_enabled            = true
    target_port                 = var.target_port
    traffic_weight {
        percentage              = 100
        latest_revision         = true
    }
  }

  timeouts {
    create                      = "60m"
  }
}