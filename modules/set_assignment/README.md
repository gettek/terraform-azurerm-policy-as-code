# POLICY INITIATIVE ASSIGNMENT MODULE



## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_policy_assignment.set](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/policy_assignment) | resource |
| [azurerm_policy_remediation.rem](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/policy_remediation) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_assignment_description"></a> [assignment\_description](#input\_assignment\_description) | A description to use for the Policy Assignment. Changing this forces a new resource to be created | `string` | `""` | no |
| <a name="input_assignment_display_name"></a> [assignment\_display\_name](#input\_assignment\_display\_name) | The policy assignment display name, if blank the definition display\_name will be used. Changing this forces a new resource to be created | `string` | `""` | no |
| <a name="input_assignment_effect"></a> [assignment\_effect](#input\_assignment\_effect) | The effect of the policy. Changing this forces a new resource to be created | `string` | `null` | no |
| <a name="input_assignment_enforcement_mode"></a> [assignment\_enforcement\_mode](#input\_assignment\_enforcement\_mode) | Can be set to 'true' or 'false' to control whether the assignment is enforced | `bool` | `true` | no |
| <a name="input_assignment_location"></a> [assignment\_location](#input\_assignment\_location) | The Azure location where this policy assignment should exist, required when an Identity is assigned. Defaults to UK South. Changing this forces a new resource to be created | `string` | `"uksouth"` | no |
| <a name="input_assignment_not_scopes"></a> [assignment\_not\_scopes](#input\_assignment\_not\_scopes) | A list of the Policy Assignment's excluded scopes. Must be full resource IDs | `list` | `[]` | no |
| <a name="input_assignment_parameters"></a> [assignment\_parameters](#input\_assignment\_parameters) | The policy assignment parameters. Changing this forces a new resource to be created | `any` | `null` | no |
| <a name="input_assignment_scope"></a> [assignment\_scope](#input\_assignment\_scope) | The scope at which the policy initiative will be assigned. Must be full resource IDs. Changing this forces a new resource to be created | `string` | n/a | yes |
| <a name="input_initiative"></a> [initiative](#input\_initiative) | Policy Initiative resource node | `any` | n/a | yes |
| <a name="input_skip_remediation"></a> [skip\_remediation](#input\_skip\_remediation) | Should the module skip creation of a remediation task for policies that DeployIfNotExists and Modify | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The Policy Assignment Id |
| <a name="output_identity_id"></a> [identity\_id](#output\_identity\_id) | The Managed Identity block containing Principal Id & Tenant Id of this Policy Assignment if type is SystemAssigned |
