data "azurerm_resource_group" "this" {
  name                = var.static_web_app_resource_group_name
}

resource "azurerm_static_site" "this" {
  name                  = var.static_web_app_name
  resource_group_name   = data.azurerm_resource_group.this.name
  location              = var.static_web_app_location
  sku_size              = var.static_web_app_tier
  sku_tier              = var.static_web_app_tier
}

resource "github_actions_secret" "az_api_key" {
  repository            = github_repository.this.name
  secret_name           = "AZURE_STATIC_WEB_APPS_API_TOKEN"
  plaintext_value       = azurerm_static_site.this.api_key
  depends_on            = [ azurerm_static_site.this ]
}

resource "time_sleep" "wait_n_seconds" {
  create_duration       = "${var.workflow_action_time}s"
  depends_on            = [ azurerm_static_site.this ]
}

data "azapi_resource" "environment_branch" {
  for_each              = var.environment_branches
  type                  = "Microsoft.Web/staticSites/builds@2022-03-01"
  name                  = each.key
  parent_id             = azurerm_static_site.this.id
  depends_on            = [ time_sleep.wait_n_seconds ]
}

resource "azapi_resource" "environment_be" {
  for_each = var.environment_branches
  type = "Microsoft.Web/staticSites/builds/linkedBackends@2022-03-01"
  name = "${each.key}-be"
  parent_id = data.azapi_resource.environment_branch[each.key].id
  body = jsonencode({
    properties = {
      backendResourceId = each.value
      region = data.azurerm_resource_group.this.location
    }
    kind = "string"
  })
}

data "azapi_resource" "default_branch" {
  type                  = "Microsoft.Web/staticSites/builds@2022-03-01"
  parent_id             = azurerm_static_site.this.id
  name                  = "default"
  depends_on            = [ time_sleep.wait_n_seconds ]
}

resource "azapi_resource" "environment_default" {
  type = "Microsoft.Web/staticSites/builds/linkedBackends@2022-03-01"
  name = "${var.default_branch}-be"
  parent_id = data.azapi_resource.default_branch.id
  body = jsonencode({
    properties = {
      backendResourceId = var.default_branch_linked_backend_resource_id
      region = data.azurerm_resource_group.this.location
    }
    kind = "string"
  })
}