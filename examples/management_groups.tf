# Org Management Group
data "azurerm_management_group" "org" {
  name = "policy_dev"
}

# Child Management Group
data "azurerm_management_group" "team_a" {
  name = "team_a"
}
