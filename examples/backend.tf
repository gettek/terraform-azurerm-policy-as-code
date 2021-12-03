terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }
}

provider "azurerm" {
  features {}
}

provider "azurerm" {
  alias           = "team_a"
  subscription_id = var.team_a_subscription_id
  features {}
}
