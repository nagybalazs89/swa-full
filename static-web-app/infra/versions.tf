terraform {
    required_providers {
        github = {
            source  = "integrations/github"
            version = "~> 5.0"
        }
        azurerm = {
            source  = "hashicorp/azurerm"
            version = "~>3.44"
        }
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

provider "github" {
    token = "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"
}