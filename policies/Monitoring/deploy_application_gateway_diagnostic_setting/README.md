# Deploy Diagnostic Settings on Application Gateways

## Display Name

Deploy Diagnostic Settings for Application Gateways to Log Analytics workspace, Event Hub and Storage Account

## Mode

`Indexed`

## Description

Deploys the diagnostic settings for Application Gateways to stream to a regional Log Analytics workspace, Event Hub and Storage Account when any Event Hub which is missing this diagnostic settings is created or updated.

## Built-In Reference

Modified from: [Built-In Samples: DiagnosticSettingsForNSG_Deploy.json](https://github.com/Azure/azure-policy/blob/master/built-in-policies/policyDefinitions/Monitoring/DiagnosticSettingsForNSG_Deploy.json)

# Examples

## Assignment
```hcl
module logging_mg_deploy_application_gateway_diagnostic_setting {
  source                = "github.com/gettek/azurerm-terraform-policy-as-code.git//modules/def_assignment?ref=1.2.0"
  definition_name       = "deploy_application_gateway_diagnostic_setting"
  definition_version    = "1.0.0"
  definition_scope      = data.azurerm_management_group.org.id
  assignment_scope      = data.azurerm_management_group.logging.id
  assignment_effect     = "DeployIfNotExists"
  assignment_parameters = {
    workspaceId                 = data.azurerm_log_analytics_workspace.logging_core.id
    storageAccountId            = data.azurerm_storage_account.logging_core.id
    eventHubAuthorizationRuleId = data.azurerm_eventhub_namespace_authorization_rule.logging_core_send.id
    eventHubName                = "evh-dev-uks-log-diagnostic-logs"
    metricsEnabled              = false
    logsEnabled                 = true
  }

  providers = {
    azurerm = azurerm
  }
}
```