# Org Management Group
resource azurerm_management_group org {
  name         = "policy_dev"
  display_name = "Policy Dev"
}

# Child Management Group
resource azurerm_management_group team_a {
  name                       = "team_a"
  display_name               = "Team A"
  parent_management_group_id = azurerm_management_group.org.id
}
