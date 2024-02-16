<!-- BEGIN_TF_DOCS -->
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

Loop around a folders contents to create multiple definitions:

```hcl
module "iam_test" {
  source = "gettek/policy-as-code/azurerm//modules/definition"
  for_each = {
    for p in fileset(path.module, "../../azure/governance/policies/Storage/*.json") :
    trimsuffix(basename(p), ".json") => pathexpand(p)
  }
  file_path           = each.value
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
| terraform | >= 0.13 |
| azurerm | >=3.23.0 |



## Resources

| Name | Type |
|------|------|
| [azurerm_policy_definition.def](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/policy_definition) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| display_name | Display Name to be used for this policy | `string` | `""` | no |
| file_path | The filepath to the custom policy. Omitting this assumes the policy is located in the module library | `any` | `null` | no |
| management_group_id | The management group scope at which the policy will be defined. Defaults to current Subscription if omitted. Changing this forces a new resource to be created. | `string` | `null` | no |
| policy_category | The category of the policy, when using the module library this should correspond to the correct category folder under /policies/<policy_category> | `string` | `null` | no |
| policy_description | Policy definition description | `string` | `""` | no |
| policy_metadata | The metadata for the policy definition. This is a JSON object representing additional metadata that should be stored with the policy definition. Omitting this will fallback to meta in the definition or merge var.policy_category and var.policy_version | `any` | `null` | no |
| policy_mode | Specify which Resource Provider modes will be evaluated, defaults to All. Possible values are All, Indexed, Microsoft.Kubernetes.Data, Microsoft.KeyVault.Data or Microsoft.Network.Data | `string` | `null` | no |
| policy_name | Name to be used for this policy, when using the module library this should correspond to the correct category folder under /policies/policy_category/policy_name. Changing this forces a new resource to be created. | `string` | `""` | no |
| policy_parameters | Parameters for the policy definition. This field is a JSON object representing the parameters of your policy definition. Omitting this assumes the parameters are located in the policy file | `any` | `null` | no |
| policy_rule | The policy rule for the policy definition. This is a JSON object representing the rule that contains an if and a then block. Omitting this assumes the rules are located in the policy file | `any` | `null` | no |
| policy_version | The version for this policy, if different from the one stored in the definition metadata, defaults to 1.0.0 | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| definition | The combined Policy Definition resource node |
| id | The Id of the Policy Definition |
| metadata | The metadata of the Policy Definition |
| name | The name of the Policy Definition |
| parameters | The parameters of the Policy Definition |
| rules | The rules of the Policy Definition |
<!-- END_TF_DOCS -->