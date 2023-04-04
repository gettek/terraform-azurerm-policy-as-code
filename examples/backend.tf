terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.44.0"
    }
  }
}

provider "azurerm" {
  features {}
}
