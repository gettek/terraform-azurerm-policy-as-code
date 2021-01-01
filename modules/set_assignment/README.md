# POLICY INITIATIVE ASSIGNMENT MODULE

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| azurerm | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| assignment\_description | A description to use for the Policy Assignment. Changing this forces a new resource to be created | `string` | `null` | no |
| assignment\_display\_name | The policy assignment display name, if blank the definition display\_name will be used. Changing this forces a new resource to be created | `string` | `null` | no |
| assignment\_effect | The effect of the policy. Changing this forces a new resource to be created | `string` | `null` | no |
| assignment\_enforcement\_mode | Can be set to 'true' or 'false' to control whether the assignment is enforced | `bool` | `true` | no |
| assignment\_location | The Azure location where this policy assignment should exist, required when an Identity is assigned. Defaults to UK South. Changing this forces a new resource to be created | `string` | `null` | no |
| assignment\_not\_scopes | A list of the Policy Assignment's excluded scopes. Must be full resource IDs | `list` | `[]` | no |
| assignment\_parameters | The policy assignment parameters. Changing this forces a new resource to be created | `any` | `null` | no |
| assignment\_scope | The scope at which the policy initiative will be assigned. Must be full resource IDs. Changing this forces a new resource to be created | `string` | n/a | yes |
| initiative | Policy Initiative resource node | `any` | n/a | yes |
| skip\_remediation | Should the module skip creation of a remediation task for policies that DeployIfNotExists and Modify | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The Policy Assignment Id |
| identity | The Managed Identity block containing Principal Id & Tenant Id of this Policy Assignment if type is SystemAssigned, referenced with \*.principal\_id[0] or \*.tenant\_id[0] |
