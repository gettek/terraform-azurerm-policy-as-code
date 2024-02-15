# POLICY INITIATIVE ASSIGNMENT MODULE

Assignments can be scoped from overarching management groups right down to individual resources

> 💡 **Note:**  A role assignment and remediation task will be automatically created if any member definitions contain a list of `roleDefinitionIds`. This can be omitted with `skip_role_assignment = true`, or to assign roles at a different scope to that of the policy assignment use: `role_assignment_scope`. To successfully create Role-assignments (or group memberships) the deployment account may require the [User Access Administrator](https://learn.microsoft.com/en-us/azure/role-based-access-control/built-in-roles#user-access-administrator) role at the `assignment_scope` or preferably the `definition_scope` to simplify workflows.

## Examples

### Custom Policy Initiative Assignment with Not-Scope and Overrides (preview)

The optional `overrides` property allows you to change the effect of a member definition without modifying the underlying policy definition or using a parameterized effect in the policy definition.

> 📘 [Microsoft Docs: Azure Policy assignment structure (Overrides)](https://learn.microsoft.com/en-us/azure/governance/policy/concepts/assignment-structure#overrides-preview)
> 💡 **Note:** This module also supports Resource selectors (preview), see the [`def_assignment`](../def_assignment) module for an example input

```hcl
module org_mg_configure_asc_initiative {
  source                 = "gettek/policy-as-code/azurerm//modules/set_assignment"
  initiative             = module.configure_asc_initiative.initiative
  assignment_scope       = data.azurerm_management_group.org.id
  assignment_effect      = "DeployIfNotExists"

  # resource remediation options
  skip_role_assignment   = false
  skip_remediation       = false
  re_evaluate_compliance = true

  assignment_parameters = {
    workspaceId           = local.dummy_resource_ids.azurerm_log_analytics_workspace
    eventHubDetails       = local.dummy_resource_ids.azurerm_eventhub_namespace_authorization_rule
    securityContactsEmail = "admin@cloud.com"
    securityContactsPhone = "44897654987"
  }

  assignment_not_scopes = [
    data.azurerm_management_group.team_a.id
  ]

  # use the 'non_compliance_messages' output from the initiative module to use auto generated messages based off policy properties: descriptions/display names/custom ones found in metadata
  # override with your own Key/Value pairs map as 'policy_definition_reference_id = content', use null = 'content' to specify the Default non-compliance message for all member definitions.
  non_compliance_messages = module.configure_asc_initiative.non_compliance_messages

  # optional overrides (preview)
  overrides = [
    {
      effect = "AuditIfNotExists"
      selectors = {
        in = [ "ExportAscAlertsAndRecommendationsToEventhub", "ExportAscAlertsAndRecommendationsToLogAnalytics" ]
      }
    },
    {
      effect = "Disabled"
      selectors = {
        in = [ "AutoSetContactDetails" ]
      }
    }
  ]
}
```

### Built-In Policy Initiative Assignment
```hcl
# Should use name instead of display name, as Microsoft changes the display names.
data "azurerm_policy_set_definition" "cis_1_3_0" {
  name = "612b5213-9160-4969-8578-1518bd2a000c" #"CIS Microsoft Azure Foundations Benchmark v1.3.0"
}

module org_mg_cis_1_3_0_benchmark {
  source           = "gettek/policy-as-code/azurerm//modules/set_assignment"
  initiative       = data.azurerm_policy_set_definition.cis_1_3_0
  assignment_scope = data.azurerm_management_group.org.id

  assignment_parameters = {
    "effect-b954148f-4c11-4c38-8221-be76711e194a-MicrosoftSql-servers-firewallRules-delete" = "Disabled"
  }
}
```

### Built-In Policy Initiative Containing DINE/Modify Assignment

```hcl
# Should use name instead of display name, as Microsoft changes the display names.
data "azurerm_policy_set_definition" "configure_az_monitor_linux_vm_initiative" {
  name = "118f04da-0375-44d1-84e3-0fd9e1849403" #"Configure Linux machines to run Azure Monitor Agent and associate them to a Data Collection Rule"
}

data "azurerm_role_definition" "vm_contributor" {
  name = "Virtual Machine Contributor"
}

module org_mg_configure_az_monitor_linux_vm_initiative {
  source           = "gettek/policy-as-code/azurerm//modules/set_assignment"
  initiative       = data.azurerm_policy_set_definition.configure_az_monitor_linux_vm_initiative
  assignment_scope = data.azurerm_management_group.org.id
  skip_remediation = false

  role_definition_ids = [
    data.azurerm_role_definition.vm_contributor.id
  ]

  assignment_parameters = {
    listOfLinuxImageIdToInclude = []
    dcrResourceId               = "/Data/Collection/Rule/Resource/Id"
  }
}
```
