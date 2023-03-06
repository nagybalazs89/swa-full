terraform {
    required_providers {
        azapi = {
          source = "azure/azapi"
          version = "~>1.3"
        }
    }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}