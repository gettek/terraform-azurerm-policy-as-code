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

  # optional non-compliance messages. Key/Value pairs map as policy_definition_reference_id = 'content'
  non_compliance_messages = {
    null                    = "The Default non-compliance message for all member definitions"
    AutoEnrollSubscriptions = "The non-compliance message for the auto_enroll_subscriptions definition"
  }

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


## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=3.49.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.53.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_management_group_policy_assignment.set](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group_policy_assignment) | resource |
| [azurerm_management_group_policy_remediation.rem](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group_policy_remediation) | resource |
| [azurerm_resource_group_policy_assignment.set](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group_policy_assignment) | resource |
| [azurerm_resource_group_policy_remediation.rem](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group_policy_remediation) | resource |
| [azurerm_resource_policy_assignment.set](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_policy_assignment) | resource |
| [azurerm_resource_policy_remediation.rem](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_policy_remediation) | resource |
| [azurerm_role_assignment.rem_role](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_subscription_policy_assignment.set](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subscription_policy_assignment) | resource |
| [azurerm_subscription_policy_remediation.rem](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subscription_policy_remediation) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_assignment_description"></a> [assignment\_description](#input\_assignment\_description) | A description to use for the Policy Assignment, defaults to initiative description. Changing this forces a new resource to be created | `string` | `null` | no |
| <a name="input_assignment_display_name"></a> [assignment\_display\_name](#input\_assignment\_display\_name) | The policy assignment display name, defaults to initiative display\_name. Changing this forces a new resource to be created | `string` | `null` | no |
| <a name="input_assignment_effect"></a> [assignment\_effect](#input\_assignment\_effect) | The effect of the policy. Changing this forces a new resource to be created | `string` | `null` | no |
| <a name="input_assignment_enforcement_mode"></a> [assignment\_enforcement\_mode](#input\_assignment\_enforcement\_mode) | Control whether the assignment is enforced | `bool` | `true` | no |
| <a name="input_assignment_location"></a> [assignment\_location](#input\_assignment\_location) | The Azure location where this policy assignment should exist, required when an Identity is assigned. Defaults to UK South. Changing this forces a new resource to be created | `string` | `"uksouth"` | no |
| <a name="input_assignment_metadata"></a> [assignment\_metadata](#input\_assignment\_metadata) | The optional metadata for the policy assignment. | `any` | `null` | no |
| <a name="input_assignment_name"></a> [assignment\_name](#input\_assignment\_name) | The name which should be used for this Policy Assignment, defaults to initiative name. Changing this forces a new Policy Assignment to be created | `string` | `null` | no |
| <a name="input_assignment_not_scopes"></a> [assignment\_not\_scopes](#input\_assignment\_not\_scopes) | A list of the Policy Assignment's excluded scopes. Must be full resource IDs | `list(any)` | `[]` | no |
| <a name="input_assignment_parameters"></a> [assignment\_parameters](#input\_assignment\_parameters) | The policy assignment parameters. Changing this forces a new resource to be created | `any` | `null` | no |
| <a name="input_assignment_scope"></a> [assignment\_scope](#input\_assignment\_scope) | The scope at which the policy initiative will be assigned. Must be full resource IDs. Changing this forces a new resource to be created | `string` | n/a | yes |
| <a name="input_failure_percentage"></a> [failure\_percentage](#input\_failure\_percentage) | (Optional) A number between 0.0 to 1.0 representing the percentage failure threshold. The remediation will fail if the percentage of failed remediation operations (i.e. failed deployments) exceeds this threshold. | `number` | `null` | no |
| <a name="input_identity_ids"></a> [identity\_ids](#input\_identity\_ids) | Optional list of User Managed Identity IDs which should be assigned to the Policy Initiative | `list(any)` | `null` | no |
| <a name="input_initiative"></a> [initiative](#input\_initiative) | Policy Initiative resource node | `any` | n/a | yes |
| <a name="input_location_filters"></a> [location\_filters](#input\_location\_filters) | Optional list of the resource locations that will be remediated | `list(any)` | `[]` | no |
| <a name="input_non_compliance_messages"></a> [non\_compliance\_messages](#input\_non\_compliance\_messages) | The optional non-compliance message(s). Key/Value pairs map as policy\_definition\_reference\_id = 'content', use null = 'content' to specify the Default non-compliance message for all member definitions. | `any` | `{}` | no |
| <a name="input_overrides"></a> [overrides](#input\_overrides) | Optional list of assignment Overrides (preview), max 10. Allows you to change the effect of a policy definition without modifying the underlying policy definition or using a parameterized effect in the policy definition | `list(any)` | `[]` | no |
| <a name="input_parallel_deployments"></a> [parallel\_deployments](#input\_parallel\_deployments) | (Optional) Determines how many resources to remediate at any given time. Can be used to increase or reduce the pace of the remediation. If not provided, the default parallel deployments value is used. | `number` | `null` | no |
| <a name="input_re_evaluate_compliance"></a> [re\_evaluate\_compliance](#input\_re\_evaluate\_compliance) | Sets the remediation task resource\_discovery\_mode for policies that DeployIfNotExists and Modify. false = 'ExistingNonCompliant' and true = 'ReEvaluateCompliance'. Defaults to false. Applies at subscription scope and below | `bool` | `false` | no |
| <a name="input_remediation_scope"></a> [remediation\_scope](#input\_remediation\_scope) | The scope at which the remediation tasks will be created. Must be full resource IDs. Defaults to the policy assignment scope. Changing this forces a new resource to be created | `string` | `null` | no |
| <a name="input_resource_count"></a> [resource\_count](#input\_resource\_count) | (Optional) Determines the max number of resources that can be remediated by the remediation job. If not provided, the default resource count is used. | `number` | `null` | no |
| <a name="input_resource_selectors"></a> [resource\_selectors](#input\_resource\_selectors) | Optional list of Resource selectors (preview), max 10. These facilitate safe deployment practices (SDP) by enabling you to gradually roll out policy assignments based on factors like resource location, resource type, or whether a resource has a location | `list(any)` | `[]` | no |
| <a name="input_role_assignment_scope"></a> [role\_assignment\_scope](#input\_role\_assignment\_scope) | The scope at which role definition(s) will be assigned, defaults to Policy Assignment Scope. Must be full resource IDs. Ignored when using Managed Identities. Changing this forces a new resource to be created | `string` | `null` | no |
| <a name="input_role_definition_ids"></a> [role\_definition\_ids](#input\_role\_definition\_ids) | List of Role definition ID's for the System Assigned Identity. Omit this to use those located in policy definitions. Ignored when using Managed Identities. Changing this forces a new resource to be created | `list(string)` | `[]` | no |
| <a name="input_skip_remediation"></a> [skip\_remediation](#input\_skip\_remediation) | Should the module skip creation of a remediation task for policies that DeployIfNotExists and Modify | `bool` | `false` | no |
| <a name="input_skip_role_assignment"></a> [skip\_role\_assignment](#input\_skip\_role\_assignment) | Should the module skip creation of role assignment for policies that DeployIfNotExists and Modify | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_definition_reference_ids"></a> [definition\_reference\_ids](#output\_definition\_reference\_ids) | The Member Definition Reference Ids |
| <a name="output_definition_references"></a> [definition\_references](#output\_definition\_references) | The Member Definition References |
| <a name="output_id"></a> [id](#output\_id) | The Policy Assignment Id |
| <a name="output_principal_id"></a> [principal\_id](#output\_principal\_id) | The Principal Id of this Policy Assignment's Managed Identity if type is SystemAssigned |
| <a name="output_remediation_tasks"></a> [remediation\_tasks](#output\_remediation\_tasks) | The Remediation Task Ids and related Policy Definition Ids |
