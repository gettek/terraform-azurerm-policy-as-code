# POLICY INITIATIVE MODULE

Dynamically creates a policy set based on multiple policy definition references



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
| [azurerm_policy_set_definition.set](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/policy_set_definition) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_initiative_category"></a> [initiative\_category](#input\_initiative\_category) | The category of the initiative | `string` | `"General"` | no |
| <a name="input_initiative_description"></a> [initiative\_description](#input\_initiative\_description) | Policy initiative description | `string` | `""` | no |
| <a name="input_initiative_display_name"></a> [initiative\_display\_name](#input\_initiative\_display\_name) | Policy initiative display name | `string` | n/a | yes |
| <a name="input_initiative_name"></a> [initiative\_name](#input\_initiative\_name) | Policy initiative name. Changing this forces a new resource to be created | `string` | n/a | yes |
| <a name="input_initiative_version"></a> [initiative\_version](#input\_initiative\_version) | The version for this initiative, defaults to 1.0.0 | `string` | `"1.0.0"` | no |
| <a name="input_management_group_name"></a> [management\_group\_name](#input\_management\_group\_name) | The scope at which the initiative will be defined. Currently this must be the group\_id of a management group. Changing this forces a new resource to be created | `string` | `null` | no |
| <a name="input_member_definitions"></a> [member\_definitions](#input\_member\_definitions) | Policy Defenition resource nodes that will be members of this initiative | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The Id of the Policy Set Definition |
| <a name="output_initiative"></a> [initiative](#output\_initiative) | The complete Policy Initiative resource node |
| <a name="output_metadata"></a> [metadata](#output\_metadata) | The metadata of the Policy Set Definition |
| <a name="output_name"></a> [name](#output\_name) | The name of the Policy Set Definition |
| <a name="output_parameters"></a> [parameters](#output\_parameters) | The combined parameters of the Policy Set Definition |
