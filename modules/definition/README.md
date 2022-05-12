# POLICY DEFINITION MODULE

This module depends on populating `var.policy_category` and `var.policy_name` to correspond with the respective custom policy definition `json` file found in the [local library](../../policies/).

> 💡 **Note:** More information on Policy Definition Structure [can be found here](https://docs.microsoft.com/en-us/azure/governance/policy/concepts/definition-structure)

> 💡 **Note:** Specify the `policy_mode` variable if you wish to [change the mode](https://docs.microsoft.com/en-us/azure/governance/policy/concepts/definition-structure#mode) which defaults to `All`. Possible values below.

## Examples

### Create a basic Policy Definition

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

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | Display Name to be used for this policy | `string` | `""` | no |
| <a name="input_management_group_id"></a> [management\_group\_id](#input\_management\_group\_id) | The management group scope at which the policy will be defined. Defaults to current Subscription if omitted. Changing this forces a new resource to be created. Note: if you are using azurerm\_management\_group to assign a value to management\_group\_id, be sure to use name or group\_id attribute, but not id. | `string` | `null` | no |
| <a name="input_policy_category"></a> [policy\_category](#input\_policy\_category) | The category of the policy, should correspond to the correct category folder under /policies/var.policy\_category | `string` | `""` | no |
| <a name="input_policy_description"></a> [policy\_description](#input\_policy\_description) | Policy definition description | `string` | `""` | no |
| <a name="input_policy_metadata"></a> [policy\_metadata](#input\_policy\_metadata) | The metadata for the policy definition. This is a JSON object representing additional metadata that should be stored with the policy definition. Omitting this will merge var.policy\_category and var.policy\_version as the metadata | `any` | `null` | no |
| <a name="input_policy_mode"></a> [policy\_mode](#input\_policy\_mode) | The policy mode that allows you to specify which resource types will be evaluated, defaults to All. Possible values are All, Indexed, Microsoft.ContainerService.Data, Microsoft.CustomerLockbox.Data, Microsoft.DataCatalog.Data, Microsoft.KeyVault.Data, Microsoft.Kubernetes.Data, Microsoft.MachineLearningServices.Data, Microsoft.Network.Data and Microsoft.Synapse.Data | `string` | `"All"` | no |
| <a name="input_policy_name"></a> [policy\_name](#input\_policy\_name) | Name to be used for this policy, this should correspond to the correct category folder under /policies/policy\_category/policy\_name. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_policy_parameters"></a> [policy\_parameters](#input\_policy\_parameters) | Parameters for the policy definition. This field is a JSON object that allows you to parameterise your policy definition. Omitting this assumes the parameters are located in /policies/var.policy\_category/var.policy\_name.json | `any` | `null` | no |
| <a name="input_policy_rule"></a> [policy\_rule](#input\_policy\_rule) | The policy rule for the policy definition. This is a JSON object representing the rule that contains an if and a then block. Omitting this assumes the rules are located in /policies/var.policy\_category/var.policy\_name.json | `any` | `null` | no |
| <a name="input_policy_version"></a> [policy\_version](#input\_policy\_version) | The version for this policy, defaults to 1.0.0 | `string` | `"1.0.0"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_definition"></a> [definition](#output\_definition) | The combined Policy Definition resource node |
| <a name="output_id"></a> [id](#output\_id) | The Id of the Policy Definition |
| <a name="output_metadata"></a> [metadata](#output\_metadata) | The metadata of the Policy Definition |
| <a name="output_name"></a> [name](#output\_name) | The name of the Policy Definition |
| <a name="output_parameters"></a> [parameters](#output\_parameters) | The parameters of the Policy Definition |
| <a name="output_rules"></a> [rules](#output\_rules) | The rules of the Policy Definition |
