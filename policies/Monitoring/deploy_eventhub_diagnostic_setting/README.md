# Deploy Diagnostic Settings on Event Hubs

## Display Name

Deploy Diagnostic Settings for Event Hub to Log Analytics workspace, Event Hub and Storage Account

## Mode

`Indexed`

## Description

Deploys the diagnostic settings for Event Hub to stream to a regional Log Analytics workspace, Event Hub and Storage Account when any Event Hub which is missing this diagnostic settings is created or updated.

## Built-In Reference

Modified from: [Built-In: EventHub_DeployDiagnosticLog_Deploy_LogAnalytics](https://github.com/Azure/azure-policy/blob/master/built-in-policies/policyDefinitions/Monitoring/EventHub_DeployDiagnosticLog_Deploy_LogAnalytics.json)

# Examples

## Assignment
```hcl
module logging_mg_deploy_eventhub_diagnostic_setting {
  source                = "github.com/gettek/azurerm-terraform-policy-as-code.git//modules/def_assignment?ref=1.2.0"
  definition_name       = "deploy_eventhub_diagnostic_setting"
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

## Cross Subscription Role Assignment

In order to successfully remediation cross-subscription diagnostic settings, a custom role definition is required such as below.

```hcl
resource random_uuid remediate_diagnostic_settings {}

resource azurerm_role_definition remediate_diagnostic_settings {
  name               = "policy_remediates_diagnostic_settings"
  role_definition_id = random_uuid.remediate_diagnostic_settings.result
  scope              = data.azurerm_management_group.org.id
  description        = "Enables the managed identity created by policy assignment permissions to remediate non compliant resources"

  permissions {
    actions = [
      "Microsoft.Authorization/*/read",
      "Microsoft.Insights/alertRules/*",
      "Microsoft.Insights/components/*/read",
      "Microsoft.Automation/automationAccounts/*",
      "Microsoft.EventHub/namespaces/authorizationrules/listkeys/action",
      "Microsoft.Insights/alertRules/*",
      "Microsoft.Insights/diagnosticSettings/*",
      "Microsoft.OperationalInsights/*",
      "Microsoft.OperationsManagement/*",
      "Microsoft.Resources/deployments/*",
      "Microsoft.Resources/subscriptions/resourceGroups/read",
      "Microsoft.Resources/subscriptions/resourcegroups/deployments/*",
      "Microsoft.Support/*",
      "Microsoft.Storage/storageAccounts/listKeys/action",
      "Microsoft.Storage/storageAccounts/read"
    ]
  }

  assignable_scopes = [
    data.azurerm_management_group.org.id
  ]
}

resource azurerm_role_assignment logging_policy_remediates_diagnostic_settings {
  scope              = data.azurerm_management_group.logging.id
  role_definition_id = azurerm_role_definition.remediate_diagnostic_settings.role_definition_resource_id
  principal_id       = module.logging_mg_deploy_diagnostic_setting.identity_id
}
```
