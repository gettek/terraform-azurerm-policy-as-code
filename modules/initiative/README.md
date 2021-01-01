# POLICY INITIATIVE MODULE

Dynamically creates a policy set based on multiple policy definition references

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| azurerm | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| initiative\_category | The category of the initiative | `string` | `"General"` | no |
| initiative\_description | Policy initiative description | `string` | `""` | no |
| initiative\_display\_name | Policy initiative display name | `string` | n/a | yes |
| initiative\_name | Policy initiative name. Changing this forces a new resource to be created | `string` | n/a | yes |
| initiative\_version | The git tag version for this policy, will be suffixed to initiative\_display\_name and initiative\_description | `string` | `"1.0.0"` | no |
| management\_group\_name | The scope at which the initiative will be defined. Currently this must be the group\_id of a management group. Changing this forces a new resource to be created | `string` | n/a | yes |
| member\_definitions | Policy Defenition resource nodes that will be members of this initiative | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| id | The Id of the Policy Set Definition |
| initiative | The complete Policy Initiative resource node |
| metadata | The metadata of the Policy Set Definition |
| name | The name of the Policy Set Definition |
| parameters | The combined parameters of the Policy Set Definition |

