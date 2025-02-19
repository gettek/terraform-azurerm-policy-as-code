terraform {
  required_version = ">= 1.4"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=4.12.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = ">=2.45.0"
    }
  }
  backend "azurerm" {}
}

provider "azurerm" {
  features {}
}
