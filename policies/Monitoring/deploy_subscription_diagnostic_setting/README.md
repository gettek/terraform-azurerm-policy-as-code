# Deploy Diagnostic Settings on Subscriptions

## Display Name

Deploy Diagnostic Settings on Subscriptions to Log Analytics Workspace, EventHub and Storage Account

## Mode

`All`

## Description

Deploys the diagnostic settings for a Subscription to stream to a regional Log Analytics workspace, EventHub and Storage Account when any Subscription which is missing this diagnostic settings is created or updated

## Built-In Reference

Modified from: [Community: apply-diagnostic-setting-subscription-log-analytics](https://github.com/Azure/Community-Policy/tree/master/Policies/Monitoring/apply-diagnostic-setting-subscription-log-analytics)

And this [ARM Template](https://docs.microsoft.com/en-us/azure/azure-monitor/samples/resource-manager-diagnostic-settings#diagnostic-setting-for-activity-log)

# Examples

## Assignment
```hcl
module logging_mg_deploy_subscription_diagnostic_setting {
  source                = "github.com/gettek/azurerm-terraform-policy-as-code.git//modules/def_assignment?ref=1.2.0"
  definition_name       = "deploy_subscription_diagnostic_setting"
  definition_version    = "1.0.0"
  definition_scope      = data.azurerm_management_group.org.id
  assignment_scope      = data.azurerm_management_group.logging.id
  assignment_effect     = "DeployIfNotExists"
  assignment_parameters = {
    workspaceId                 = data.azurerm_log_analytics_workspace.logging_core.id
    storageAccountId            = data.azurerm_storage_account.logging_core.id
    eventHubAuthorizationRuleId = data.azurerm_eventhub_namespace_authorization_rule.logging_core_send.id
    eventHubName                = "evh-dev-uks-log-diagnostic-logs"
  }

  providers = {
    azurerm = azurerm
  }
}
```

## Cross Subscription Role Assignment

In order to successfully remediation cross-subscription diagnostic settings, a custom or built-in role definition reference is required such as below.

```hcl
data "azurerm_role_definition" "contributor" {
  name = "Contributor"
}

resource azurerm_role_assignment logging_policy_remediates_diagnostic_settings {
  scope              = data.azurerm_management_group.logging.id
  role_definition_id = data.azurerm_role_definition.contributor.id
  principal_id       = module.logging_mg_deploy_subscription_diagnostic_setting.identity_id
}
```

# Notes

The `strongType` metadata below have been removed from [Parameter properties](https://docs.microsoft.com/en-us/azure/governance/policy/concepts/definition-structure#parameter-properties) as we are automatically parsing the full resource IDs, [See here](https://github.com/terraform-providers/terraform-provider-azurerm/issues/5462) for more details. `strongType` intends to make assignments via the Portal simpler with drop down selections.

```json
{
    "workspaceId": {
        "type": "String",
        "metadata": {
            "displayName": "Log Analytics workspace Id",
            "description": "Select Log Analytics workspace from dropdown list. If this workspace is outside of the scope of the assignment you must manually grant 'Log Analytics Contributor' permissions (or similar) to the policy assignment's principal ID.",
            "strongType": "omsWorkspace",
            "assignPermissions": true
        }
    },
    "storageAccountId": {
        "type": "String",
        "metadata": {
            "displayName": "Storage Account Id",
            "description": "The Storage Account Resource Id to send activity logs",
            "strongType": "Microsoft.Storage/StorageAccounts",
            "assignPermissions": true
        }
    },
    "eventHubAuthorizationRuleId": {
        "type": "String",
        "metadata": {
            "displayName": "Event Hub Authorization Rule Id",
            "description": "The Event Hub authorization rule Id for Azure Diagnostics. The authorization rule needs to be at Event Hub namespace level. e.g. /subscriptions/{subscription Id}/resourceGroups/{resource group}/providers/Microsoft.EventHub/namespaces/{Event Hub namespace}/authorizationrules/{authorization rule}",
            "strongType": "Microsoft.EventHub/Namespaces/AuthorizationRules",
            "assignPermissions": true
        }
    },
    "eventHubName": {
        "type": "String",
        "metadata": {
            "displayName": "EventHub name",
            "description": "The EventHub name to stream activity logs to",
            "strongType": "Microsoft.EventHub/Namespaces/EventHubs",
            "assignPermissions": true
        }
    }
}
```