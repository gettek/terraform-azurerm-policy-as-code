# POLICY DEFINITION MODULE

This module depends on populating `var.policy_category` and `var.policy_name` to correspond with the respective custom policy definition `json` file found in the [local library](../../policies/).

> :bulb: **Note:** More information on Policy Definition Structure [can be found here](https://docs.microsoft.com/en-us/azure/governance/policy/concepts/definition-structure)

## Examples

### Create a basic Policy Definition

```hcl
module whitelist_regions {
  source                = "gettek/policy-as-code/azurerm//modules/definition"
  version               = "2.3.0"
  policy_name           = "whitelist_regions"
  display_name          = "Allow resources only in whitelisted regions"
  policy_category       = "General"
  management_group      = local.default_management_group_scope_name
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
  management_group      = data.azurerm_management_group.org.name
}
```
