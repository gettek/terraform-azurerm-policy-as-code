locals {
  # existing resources would typically be referenced up with a datasource
  dummy_resource_ids = {
    azurerm_log_analytics_workspace               = "/uri/log-analytics-workspace-diagnostics"
    azurerm_storage_account                       = "/uri/storage-account-archive"
    azurerm_eventhub_namespace                    = "/uri/event-hub-namespace-diagnostics"
    azurerm_eventhub_namespace_authorization_rule = "/uri/event-hub-namespace-diagnostics/RootManageSharedAccessKey"
  }
}

data "azurerm_role_definition" "contributor" {
  name = "Contributor"
}
