# POLICY DEFINITION MODULE

This module depends on populating `var.policy_category` and `var.policy_name` to correspond with the subfolder containing the policy definition `json` files, expected as `parameters.json` and `rules.json`.

> :bulb: **Note:** More information on Policy Defenition Structure [can be found here](https://docs.microsoft.com/en-us/azure/governance/policy/concepts/definition-structure)



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
| [azurerm_policy_definition.def](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/policy_definition) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | Display Name to be used for this policy | `string` | n/a | yes |
| <a name="input_management_group_name"></a> [management\_group\_name](#input\_management\_group\_name) | The management group scope at which the policy will be defined. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_policy_category"></a> [policy\_category](#input\_policy\_category) | The category of the policy, should correspond to the correct category folder under /policies/policy\_category | `string` | n/a | yes |
| <a name="input_policy_description"></a> [policy\_description](#input\_policy\_description) | Policy definition description | `string` | `""` | no |
| <a name="input_policy_metadata"></a> [policy\_metadata](#input\_policy\_metadata) | The metadata for the policy definition. This is a JSON string representing additional metadata that should be stored with the policy definition. Omitting this will merge var.policy\_category and var.policy\_version as the metadata | `any` | `null` | no |
| <a name="input_policy_mode"></a> [policy\_mode](#input\_policy\_mode) | The mode of the policy, can be All or Indexed | `string` | `"All"` | no |
| <a name="input_policy_name"></a> [policy\_name](#input\_policy\_name) | Name to be used for this policy, this should correspond to the correct category folder under /policies/policy\_category/policy\_name if using local policies. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_policy_parameters"></a> [policy\_parameters](#input\_policy\_parameters) | Parameters for the policy definition. This field is a JSON string that allows you to parameterise your policy definition. Omitting this assumes the file is located at /policies/var.policy\_category/var.policy\_name/parameters.json | `any` | `null` | no |
| <a name="input_policy_rule"></a> [policy\_rule](#input\_policy\_rule) | The policy rule for the policy definition. This is a JSON string representing the rule that contains an if and a then block. Omitting this assumes the file is located at /policies/var.policy\_category/var.policy\_name/rules.json/ | `any` | `null` | no |
| <a name="input_policy_version"></a> [policy\_version](#input\_policy\_version) | The version for this policy, defaults to 1.0.0 | `string` | `"1.0.0"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_definition"></a> [definition](#output\_definition) | The complete resource node of the Policy Definition |
| <a name="output_id"></a> [id](#output\_id) | The Id of the Policy Definition |
| <a name="output_metadata"></a> [metadata](#output\_metadata) | The metadata of the Policy Definition |
| <a name="output_name"></a> [name](#output\_name) | The name of the Policy Definition |
| <a name="output_parameters"></a> [parameters](#output\_parameters) | The parameters of the Policy Definition |
| <a name="output_rules"></a> [rules](#output\_rules) | The rules of the Policy Definition |
