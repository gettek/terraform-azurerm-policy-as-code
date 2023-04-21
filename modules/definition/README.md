# POLICY DEFINITION MODULE

This module depends on populating `var.policy_name` and `var.policy_category` to correspond with the respective custom policy definition `json` file found in the [local library](../../policies). You can also parse in other template files and data sources at runtime, see below for examples and acceptable inputs.

> 💡 **Note:** More information on Policy Definition Structure [can be found here](https://learn.microsoft.com/en-us/azure/governance/policy/concepts/definition-structure)

> 💡 **Note:** Specify the `policy_mode` variable if you wish to [change the mode](https://learn.microsoft.com/en-us/azure/governance/policy/concepts/definition-structure#mode) which defaults to `All`. Possible values below.

## Examples

### Create a basic Policy Definition from a file located in the module library

```hcl
module whitelist_regions {
  source                = "gettek/policy-as-code/azurerm//modules/definition"
  policy_name           = "whitelist_regions"
  display_name          = "Allow resources only in whitelisted regions"
  policy_category       = "General"
  management_group_id   = data.azurerm_management_group.org.id
}
```

### Loop around a map to quickly create multiple definitions
```hcl
locals {
  security_center_policies = {
    auto_enroll_subscriptions                              = "Enable Azure Security Center on Subcriptions"
    auto_provision_log_analytics_agent_custom_workspace    = "Enable Security Center's auto provisioning of the Log Analytics agent on your subscriptions with custom workspace"
    auto_set_contact_details                               = "Automatically set the security contact email address and phone number should they be blank on the subscription"
    export_asc_alerts_and_recommendations_to_eventhub      = "Export to Event Hub for Azure Security Center alerts and recommendations"
    export_asc_alerts_and_recommendations_to_log_analytics = "Export to Log Analytics Workspace for Azure Security Center alerts and recommendations"
  }
}

module "configure_asc" {
  source                = "gettek/policy-as-code/azurerm//modules/definition"
  for_each              = local.security_center_policies
  policy_name           = each.key
  display_name          = title(replace(each.key, "_", " "))
  policy_description    = each.value
  policy_category       = "Security Center"
  management_group_id   = data.azurerm_management_group.org.id
}
```

### Use definition files located outside of the module library

```hcl
module "file_path_test" {
  source              = "gettek/policy-as-code/azurerm//modules/definition"
  file_path           = "../path/to/file/onboard_to_automation_dsc_linux.json"
  management_group_id = data.azurerm_management_group.org.id
}
```

You will also be able to supply object properties at runtime such as:
```hcl
locals {
  policy_file = jsondecode(file("onboard_to_automation_dsc_linux.json"))
}

module "parameterised_test" {
  source              = "gettek/policy-as-code/azurerm//modules/definition"
  policy_name         = "Custom Name"
  display_name        = "Custom Display Name"
  policy_description  = "Custom Description"
  policy_category     = "Custom Category"
  policy_version      = "Custom Version"
  management_group_id = data.azurerm_management_group.org.id

  policy_rule       = (local.policy_file).properties.policyRule
  policy_parameters = (local.policy_file).properties.parameters
  policy_metadata   = (local.policy_file).properties.metadata
}
```


## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=3.23.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.53.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_policy_definition.def](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/policy_definition) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | Display Name to be used for this policy | `string` | `""` | no |
| <a name="input_file_path"></a> [file\_path](#input\_file\_path) | The filepath to the custom policy. Omitting this assumes the policy is located in the module library | `any` | `null` | no |
| <a name="input_management_group_id"></a> [management\_group\_id](#input\_management\_group\_id) | The management group scope at which the policy will be defined. Defaults to current Subscription if omitted. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_policy_category"></a> [policy\_category](#input\_policy\_category) | The category of the policy, when using the module library this should correspond to the correct category folder under /policies/var.policy\_category | `string` | `null` | no |
| <a name="input_policy_description"></a> [policy\_description](#input\_policy\_description) | Policy definition description | `string` | `""` | no |
| <a name="input_policy_metadata"></a> [policy\_metadata](#input\_policy\_metadata) | The metadata for the policy definition. This is a JSON object representing additional metadata that should be stored with the policy definition. Omitting this will fallback to meta in the definition or merge var.policy\_category and var.policy\_version | `any` | `null` | no |
| <a name="input_policy_mode"></a> [policy\_mode](#input\_policy\_mode) | The policy mode that allows you to specify which resource types will be evaluated, defaults to All. Possible values are All and Indexed | `string` | `null` | no |
| <a name="input_policy_name"></a> [policy\_name](#input\_policy\_name) | Name to be used for this policy, when using the module library this should correspond to the correct category folder under /policies/policy\_category/policy\_name. Changing this forces a new resource to be created. | `string` | `""` | no |
| <a name="input_policy_parameters"></a> [policy\_parameters](#input\_policy\_parameters) | Parameters for the policy definition. This field is a JSON object that allows you to parameterise your policy definition. Omitting this assumes the parameters are located in /policies/var.policy\_category/var.policy\_name.json | `any` | `null` | no |
| <a name="input_policy_rule"></a> [policy\_rule](#input\_policy\_rule) | The policy rule for the policy definition. This is a JSON object representing the rule that contains an if and a then block. Omitting this assumes the rules are located in /policies/var.policy\_category/var.policy\_name.json | `any` | `null` | no |
| <a name="input_policy_version"></a> [policy\_version](#input\_policy\_version) | The version for this policy, if different from the one stored in the definition metadata, defaults to 1.0.0 | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_definition"></a> [definition](#output\_definition) | The combined Policy Definition resource node |
| <a name="output_id"></a> [id](#output\_id) | The Id of the Policy Definition |
| <a name="output_metadata"></a> [metadata](#output\_metadata) | The metadata of the Policy Definition |
| <a name="output_name"></a> [name](#output\_name) | The name of the Policy Definition |
| <a name="output_parameters"></a> [parameters](#output\_parameters) | The parameters of the Policy Definition |
| <a name="output_rules"></a> [rules](#output\_rules) | The rules of the Policy Definition |
