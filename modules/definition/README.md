# POLICY DEFINITION MODULE

This reusable module depends on populating `var.policy_category` and `var.policy_name` to correspend with the subfolder containing the policy defenition `json` files, expected as `parameters.json` and `rules.json`.

> :bulb: **Note:** More information on Policy Defenition Structure [can be found here](https://docs.microsoft.com/en-us/azure/governance/policy/concepts/definition-structure)



## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| azurerm | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| display\_name | Display Name to be used for this policy | `string` | n/a | yes |
| management\_group\_name | The management group scope at which the policy will be defined. Changing this forces a new resource to be created. | `string` | n/a | yes |
| policy\_category | The category of the policy, should correspond to the correct category folder under /policies/policy\_category | `string` | n/a | yes |
| policy\_description | Policy definition description | `string` | `null` | no |
| policy\_metadata | The metadata for the policy definition. This is a JSON string representing additional metadata that should be stored with the policy definition. Omitting this will merge var.policy\_category and var.policy\_version as the metadata | `any` | `null` | no |
| policy\_mode | The mode of the policy, can be All or Indexed | `string` | `"All"` | no |
| policy\_name | Name to be used for this policy, this should correspond to the correct category folder under /policies/policy\_category/policy\_name if using local policies. Changing this forces a new resource to be created. | `string` | n/a | yes |
| policy\_parameters | Parameters for the policy definition. This field is a JSON string that allows you to parameterise your policy definition. Omitting this assumes the file is located at /policies/var.policy\_category/var.policy\_name/parameters.json | `any` | `null` | no |
| policy\_rule | The policy rule for the policy definition. This is a JSON string representing the rule that contains an if and a then block. Omitting this assumes the file is located at /policies/var.policy\_category/var.policy\_name/rules.json/ | `any` | `null` | no |
| policy\_version | The git tag or version for this policy, defaults to 1.0.0 | `string` | `"1.0.0"` | no |

## Outputs

| Name | Description |
|------|-------------|
| definition | The complete resource node of the Policy Definition |
| id | The Id of the Policy Definition |
| metadata | The metadata of the Policy Definition |
| name | The name of the Policy Definition |
| parameters | The parameters of the Policy Definition |
| rules | The rules of the Policy Definition |

