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