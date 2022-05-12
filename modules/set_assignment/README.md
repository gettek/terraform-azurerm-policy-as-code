# POLICY INITIATIVE ASSIGNMENT MODULE

Assignments can be scoped from overarching management groups right down to individual resources

> 💡 To automate Role Assignment and Remediation you must explicitly parse a list of required `role_definition_ids` to this module as seen below. You may choose to assign roles at a different scope to that of the policy assignment (default) using `role_assignment_scope`.

## Examples

### Custom Policy Initiative Assignment with Not-Scope
```hcl
module org_mg_configure_asc_initiative {
  source               = "gettek/policy-as-code/azurerm//modules/set_assignment"
  initiative           = module.configure_asc_initiative.initiative
  assignment_scope     = data.azurerm_management_group.org.id
  assignment_effect    = "DeployIfNotExists"
  skip_remediation     = false
  skip_role_assignment = false
  role_definition_ids  = module.configure_asc_initiative.role_definition_ids

  assignment_parameters = {
    workspaceId           = local.dummy_resource_ids.azurerm_log_analytics_workspace
    eventHubDetails       = local.dummy_resource_ids.azurerm_eventhub_namespace_authorization_rule
    securityContactsEmail = "admin@cloud.com"
    securityContactsPhone = "44897654987"
  }

  assignment_not_scopes = [
    data.azurerm_management_group.team_a.id
  ]

  non_compliance_message = "Example non-compliance message will be used as opposed to default policy error"
}
```

### Built-In Policy Initiative Assignment
```hcl
data "azurerm_policy_set_definition" "cis_1_3_0" {
  display_name = "CIS Microsoft Azure Foundations Benchmark v1.3.0"
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
data "azurerm_policy_set_definition" "configure_az_monitor_linux_vm_initiative" {
  display_name = "Configure Linux machines to run Azure Monitor Agent and associate them to a Data Collection Rule"
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
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=3.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >=3.0.0 |

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
| <a name="input_assignment_description"></a> [assignment\_description](#input\_assignment\_description) | A description to use for the Policy Assignment, defaults to initiative description. Changing this forces a new resource to be created | `string` | `""` | no |
| <a name="input_assignment_display_name"></a> [assignment\_display\_name](#input\_assignment\_display\_name) | The policy assignment display name, defaults to initiative display\_name. Changing this forces a new resource to be created | `string` | `""` | no |
| <a name="input_assignment_effect"></a> [assignment\_effect](#input\_assignment\_effect) | The effect of the policy. Changing this forces a new resource to be created | `string` | `null` | no |
| <a name="input_assignment_enforcement_mode"></a> [assignment\_enforcement\_mode](#input\_assignment\_enforcement\_mode) | Control whether the assignment is enforced | `bool` | `true` | no |
| <a name="input_assignment_location"></a> [assignment\_location](#input\_assignment\_location) | The Azure location where this policy assignment should exist, required when an Identity is assigned. Defaults to UK South. Changing this forces a new resource to be created | `string` | `"uksouth"` | no |
| <a name="input_assignment_name"></a> [assignment\_name](#input\_assignment\_name) | The name which should be used for this Policy Assignment, defaults to initiative name. Changing this forces a new Policy Assignment to be created | `string` | `""` | no |
| <a name="input_assignment_not_scopes"></a> [assignment\_not\_scopes](#input\_assignment\_not\_scopes) | A list of the Policy Assignment's excluded scopes. Must be full resource IDs | `list(any)` | `[]` | no |
| <a name="input_assignment_parameters"></a> [assignment\_parameters](#input\_assignment\_parameters) | The policy assignment parameters. Changing this forces a new resource to be created | `any` | `null` | no |
| <a name="input_assignment_scope"></a> [assignment\_scope](#input\_assignment\_scope) | The scope at which the policy initiative will be assigned. Must be full resource IDs. Changing this forces a new resource to be created | `string` | n/a | yes |
| <a name="input_initiative"></a> [initiative](#input\_initiative) | Policy Initiative resource node | `any` | n/a | yes |
| <a name="input_location_filters"></a> [location\_filters](#input\_location\_filters) | Optional list of the resource locations that will be remediated | `list(any)` | `[]` | no |
| <a name="input_non_compliance_message"></a> [non\_compliance\_message](#input\_non\_compliance\_message) | The optional non-compliance message text. This message will be the default for all member definitions in the set. | `string` | `""` | no |
| <a name="input_resource_discovery_mode"></a> [resource\_discovery\_mode](#input\_resource\_discovery\_mode) | The way that resources to remediate are discovered. Possible values are ExistingNonCompliant or ReEvaluateCompliance. Defaults to ExistingNonCompliant | `string` | `"ExistingNonCompliant"` | no |
| <a name="input_role_assignment_scope"></a> [role\_assignment\_scope](#input\_role\_assignment\_scope) | The scope at which role definition(s) will be assigned, defaults to Policy Assignment Scope. Must be full resource IDs. Changing this forces a new resource to be created | `string` | `null` | no |
| <a name="input_role_definition_ids"></a> [role\_definition\_ids](#input\_role\_definition\_ids) | List of Role definition ID's for the System Assigned Identity. Omit this to use those located in policy definitions. Changing this forces a new resource to be created | `list(string)` | `[]` | no |
| <a name="input_skip_remediation"></a> [skip\_remediation](#input\_skip\_remediation) | Should the module skip creation of a remediation task for policies that DeployIfNotExists and Modify | `bool` | `false` | no |
| <a name="input_skip_role_assignment"></a> [skip\_role\_assignment](#input\_skip\_role\_assignment) | Should the module skip creation of role assignment for policies that DeployIfNotExists and Modify | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_definition_references"></a> [definition\_references](#output\_definition\_references) | The Member Definition Reference Ids |
| <a name="output_id"></a> [id](#output\_id) | The Policy Assignment Id |
| <a name="output_principal_id"></a> [principal\_id](#output\_principal\_id) | The Principal Id of this Policy Assignment's Managed Identity if type is SystemAssigned |
| <a name="output_remediation_tasks"></a> [remediation\_tasks](#output\_remediation\_tasks) | The Remediation Task Ids and related Policy Definition Ids |
