terraform {
  required_version = ">= 1.4"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.12"
    }
    null = {
      source = "hashicorp/null"
    }
  }
}

provider "azurerm" {
  features {}
  resource_provider_registrations = "core"
  resource_providers_to_register = [
    "Microsoft.PolicyInsights",
    "Microsoft.SecurityInsights"
  ]
}
