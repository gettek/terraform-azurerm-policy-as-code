terraform {
  required_version = "<= 0.13.6"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.34"
    }
  }
}

provider azurerm {
  features {}
}
