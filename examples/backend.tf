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
  subscription_id = data.azurerm_client_config.current.subscription_id
  features {}
}
