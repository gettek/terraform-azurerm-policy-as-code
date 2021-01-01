# Custom CIS Benchmark 1.1.0

## Display Name

CIS Microsoft Azure Foundations Custom Benchmark 1.1.0

## Description

Covers a subset of policies defined in the CIS Microsoft Azure Foundations Benchmark 1.1.0 recommendations.

## Built-In Reference

Modified from: [Built-In: CISv1_1_0_audit](https://github.com/Azure/azure-policy/blob/master/built-in-policies/policySetDefinitions/Regulatory%20Compliance/CISv1_1_0_audit.json)

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| azurerm | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| audit\_log\_analytics\_workspace\_retention\_id | The audit\_log\_analytics\_workspace\_retention custom policy Id to replace CISv110x5x1x2 | `any` | n/a | yes |
| benchmark\_version | Usually the git tag version for this benchmark, will be suffixed to display\_name and description | `string` | `"1.0.0"` | no |
| description | Benchmark description | `string` | n/a | yes |
| display\_name | Benchmark display name | `string` | n/a | yes |
| management\_group\_name | The scope at which the benchmark will be defined. Currently this must be the group\_id of a management group. Changing this forces a new resource to be created | `string` | n/a | yes |
| name | Benchmark name. Changing this forces a new resource to be created | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| id | The Id of the Benchmark Definition |
| initiative | The complete CIS Benchmark Initiative resource node |
| metadata | The metadata of the Benchmark Definition |
| name | The name of the Benchmark Definition |
| parameters | The combined parameters of the Benchmark Definition |

