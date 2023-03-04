resource "azurerm_resource_group" "this" {
  name     = "swagroup"
  location = "West Europe"
}

resource "azurerm_static_site" "this" {
  name                = "swa-react"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  sku_size = "Standard"
  sku_tier = "Standard"
}

resource "github_actions_secret" "az_api_key" {
  repository       = github_repository.this.name
  secret_name      = "AZURE_STATIC_WEB_APPS_API_TOKEN"
  plaintext_value  = azurerm_static_site.this.api_key
  depends_on = [
    azurerm_static_site.this
  ]
}

data "azapi_resource" "build_develop" {
  type = "Microsoft.Web/staticSites/builds@2022-03-01"
  name = "development"
  parent_id = azurerm_static_site.this.id
  depends_on = [
    azurerm_container_app.example
  ]
}

# data "azapi_resource" "build_main" {
#   type = "Microsoft.Web/staticSites/builds@2022-03-01"
#   name = "Production"
#   parent_id = azurerm_static_site.this.id
# }

data "azapi_resource" "build_staging" {
  type = "Microsoft.Web/staticSites/builds@2022-03-01"
  name = "staging"
  parent_id = azurerm_static_site.this.id
  depends_on = [
    azurerm_container_app.example
  ]
}

resource "azapi_resource" "develop_be" {
  type = "Microsoft.Web/staticSites/builds/linkedBackends@2022-03-01"
  name = "leavmealone"
  parent_id = data.azapi_resource.build_develop.id
  body = jsonencode({
    properties = {
      backendResourceId = azurerm_container_app.example.id
      region = azurerm_resource_group.this.location
    }
    kind = "string"
  })
  depends_on = [
    azurerm_container_app.example
  ]
}

resource "azapi_resource" "staging_be" {
  type = "Microsoft.Web/staticSites/builds/linkedBackends@2022-03-01"
  name = "leavmealone"
  parent_id = data.azapi_resource.build_staging.id
  body = jsonencode({
    properties = {
      backendResourceId = azurerm_container_app.example.id
      region = azurerm_resource_group.this.location
    }
    kind = "string"
  })
  depends_on = [
    azurerm_container_app.example
  ]
}

# resource "azapi_resource" "main_be" {
#   type = "Microsoft.Web/staticSites/linkedBackends@2022-03-01"
#   name = "leavmealone"
#   parent_id = data.azapi_resource.build_main.id
#   body = jsonencode({
#     properties = {
#       backendResourceId = azurerm_container_app.example.id
#       region = azurerm_resource_group.this.location
#     }
#     kind = "string"
#   })
# }