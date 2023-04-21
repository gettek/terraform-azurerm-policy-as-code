data "azurerm_client_config" "current" {}

# Org Management Group
data "azurerm_management_group" "org" {
  name = "policy_dev"
}

# Child Management Group
data "azurerm_management_group" "team_a" {
  name = "team_a"
}

# Contributor role
data "azurerm_role_definition" "contributor" {
  name = "Contributor"
}

# storage container to hold custom dsc packages
data "azurerm_storage_container" "guest_config_container" {
  name                 = "configs"
  storage_account_name = "guestconfig${substr(md5(data.azurerm_client_config.current.subscription_id), 0, 5)}"
}

# Onboarding Prerequisites Initiative References:
#      [GA]: 12794019-7a00-42cf-95c2-882eed337cc8 "Deploy prerequisites to enable Guest Configuration policies on virtual machines" (SystemAssigned)
# [Preview]: 2b0ce52e-301c-4221-ab38-1601e2b4cee3 "[Preview]: Deploy prerequisites to enable Guest Configuration policies on virtual machines using user-assigned managed identity" (UserAssigned)
data "azurerm_policy_set_definition" "deploy_guest_config_prereqs_initiative" {
  name = "12794019-7a00-42cf-95c2-882eed337cc8"
}
