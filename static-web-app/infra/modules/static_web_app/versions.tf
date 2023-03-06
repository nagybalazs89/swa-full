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