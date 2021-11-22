# Custom CIS Benchmark 1.1.0

## Display Name

CIS Microsoft Azure Foundations Custom Benchmark 1.1.0

## Description

This module is created to cover a subset of policies defined in CIS Microsoft Azure Foundations Benchmark 1.1.0 recommendations. 

We do not want to assign the set defined by Azure as it is:
  1. This default set is subject to change and does not give us the control over what we can define/apply.
  2. We might not need to apply the whole set depending on the requirements we have. 
  3. Being able to reference policies through Id's -which is not an option in Terraform- decouples us from the dependency on policy display names.

## Built-In Reference

Modified from: [Built-In: CISv1_1_0_audit](https://github.com/Azure/azure-policy/blob/master/built-in-policies/policySetDefinitions/Regulatory%20Compliance/CISv1_1_0_audit.json)


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
| [azurerm_policy_set_definition.cis_benchmark](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/policy_set_definition) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_audit_log_analytics_workspace_retention_id"></a> [audit\_log\_analytics\_workspace\_retention\_id](#input\_audit\_log\_analytics\_workspace\_retention\_id) | The audit\_log\_analytics\_workspace\_retention custom policy Id to replace CISv110x5x1x2 | `any` | n/a | yes |
| <a name="input_benchmark_version"></a> [benchmark\_version](#input\_benchmark\_version) | Usually the git tag version for this benchmark | `string` | `"1.0.0"` | no |
| <a name="input_description"></a> [description](#input\_description) | Benchmark description | `string` | n/a | yes |
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | Benchmark display name | `string` | n/a | yes |
| <a name="input_management_group_name"></a> [management\_group\_name](#input\_management\_group\_name) | The scope at which the benchmark will be defined. Currently this must be the group\_id of a management group. Changing this forces a new resource to be created | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Benchmark name. Changing this forces a new resource to be created | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The Id of the Benchmark Definition |
| <a name="output_initiative"></a> [initiative](#output\_initiative) | The complete CIS Benchmark Initiative resource node |
| <a name="output_metadata"></a> [metadata](#output\_metadata) | The metadata of the Benchmark Definition |
| <a name="output_name"></a> [name](#output\_name) | The name of the Benchmark Definition |
| <a name="output_parameters"></a> [parameters](#output\_parameters) | The combined parameters of the Benchmark Definition |
