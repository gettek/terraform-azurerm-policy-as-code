data "azurerm_client_config" "current" {}

data "azurerm_subscription" "current" {}

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

# Virtual Machine Contributor role
data "azurerm_role_definition" "vm_contributor" {
  name = "Virtual Machine Contributor"
}

# User Assigned Managed Identity
data "azurerm_user_assigned_identity" "policy_rem" {
  name                = "policy-remediator"
  resource_group_name = "cgc-cd"
}

locals {
  # existing resources would typically be referenced with a datasource
  dummy_resource_ids = {
    azurerm_log_analytics_workspace               = "/uri/log-analytics-workspace-diagnostics"
    azurerm_storage_account                       = "/uri/storage-account-archive"
    azurerm_eventhub_namespace                    = "/uri/event-hub-namespace-diagnostics"
    azurerm_eventhub_namespace_authorization_rule = "/uri/event-hub-namespace-diagnostics/RootManageSharedAccessKey"
  }
}
