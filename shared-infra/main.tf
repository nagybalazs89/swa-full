resource "azurerm_resource_group" "example" {
  name                      = "swa-resources"
  location                  = "West Europe"
}

resource "azurerm_log_analytics_workspace" "example" {
  name                      = "swa-log-analitycs"
  location                  = azurerm_resource_group.example.location
  resource_group_name       = azurerm_resource_group.example.name
  sku                       = "PerGB2018"
  retention_in_days         = 30
}

resource "azurerm_container_app_environment" "example" {
  name                       = "swa-container-app-environment"
  location                   = azurerm_resource_group.example.location
  resource_group_name        = azurerm_resource_group.example.name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.example.id
}