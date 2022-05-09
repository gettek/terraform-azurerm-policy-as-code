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

# retrieve guest_config_packages_script outputs
data "local_file" "cgc_definition_list" {
  filename = "${path.module}/../scripts/definitionList.json"

  depends_on = [
    null_resource.guest_config_packages_script
  ]
}

# Retrieve Custom Config Definitions that were built and published by build_packages.tf
data "azurerm_policy_definition" "custom_guest_config_definitions" {
  for_each              = fileset("${path.module}/../scripts/dsc_examples", "*.ps1")
  name                  = format("CGC_%s", replace(each.value, ".ps1", ""))
  management_group_name = data.azurerm_management_group.org.name
}
