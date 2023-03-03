resource "azurerm_resource_group" "this" {
  name     = "swagroup"
  location = "West Europe"
}

resource "azurerm_static_site" "this" {
  name                = "swa-react"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
}

resource "github_actions_secret" "az_api_key" {
  repository       = github_repository.this.name
  secret_name      = "AZURE_STATIC_WEB_APPS_API_TOKEN"
  plaintext_value  = azurerm_static_site.this.api_key
  depends_on = [
    azurerm_static_site.this
  ]
}