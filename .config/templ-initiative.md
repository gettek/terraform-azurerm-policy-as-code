# POLICY INITIATIVE MODULE

Dynamically creates a policy set based on multiple custom or built-in policy definitions

> ⚠️ **Warning:** To simplify assignments, if any `member_definitions` contain the same parameter names they will be [merged](https://www.terraform.io/language/functions/merge) unless you specify `merge_effects = false` or `merge_parameters = false` as described in the second example below.

## Examples


### Create an Initiative with a duplicate member definitions

In many cases, some initiatives such as those for tagging, may need to reuse the same definition multiple times but with different parameters to simplify assignments.

Please see [duplicate_members.tf](../../examples/duplicate_members.tf) as en example use case.

> 💡 **Note:** you must set `duplicate_members=true` and `merge_parameters=false` when building initiatives with duplicate members.
> 💡 **Note:** Be cautious when changing the position of `member_definitions` as these reflect the index numbers used in `assignment_parameters`.


### Create an Initiative with custom Policy definitions

```hcl
module configure_asc_initiative {
  source                  = "gettek/policy-as-code/azurerm//modules/initiative"
  initiative_name         = "configure_asc_initiative"
  initiative_display_name = "[Security]: Configure Azure Security Center"
  initiative_description  = "Deploys and configures Azure Security Center settings and defines exports"
  initiative_category     = "Security Center"
  management_group_id     = data.azurerm_management_group.org.id

  member_definitions = [
    module.configure_asc["auto_enroll_subscriptions"].definition,
    module.configure_asc["auto_provision_log_analytics_agent_custom_workspace"].definition,
    module.configure_asc["auto_set_contact_details"].definition,
    module.configure_asc["export_asc_alerts_and_recommendations_to_eventhub"].definition,
    module.configure_asc["export_asc_alerts_and_recommendations_to_log_analytics"].definition,
  ]
}
```

### Create an Initiative with a mix of custom & built-in Policy definitions without merging effects

When setting `merge_effects = false` each definition effect parameter will be suffixed with its respective policy definition reference Id e.g. `"effect_AutoEnrollSubscriptions"`.

```hcl
data azurerm_policy_definition deploy_law_on_linux_vms {
  display_name = "Deploy Log Analytics extension for Linux VMs"
}

module configure_asc_initiative {
  source                  = "gettek/policy-as-code/azurerm//modules/initiative"
  initiative_name         = "configure_asc_initiative"
  initiative_display_name = "[Security]: Configure Azure Security Center"
  initiative_description  = "Deploys and configures Azure Security Center settings and defines exports"
  initiative_category     = "Security Center"
  management_group_id     = data.azurerm_management_group.org.id
  merge_effects           = false

  member_definitions = [
    module.configure_asc["auto_enroll_subscriptions"].definition,
    module.configure_asc["auto_provision_log_analytics_agent_custom_workspace"].definition,
    module.configure_asc["auto_set_contact_details"].definition,
    module.configure_asc["export_asc_alerts_and_recommendations_to_eventhub"].definition,
    module.configure_asc["export_asc_alerts_and_recommendations_to_log_analytics"].definition,
    data.azurerm_policy_definition.deploy_law_on_linux_vms,
  ]
}

# get all the generated parameter names so we know what to use during assignment
output "list_of_initiative_parameters" {
  value = keys(module.configure_asc_initiative.parameters)
}
```

### Populate member_definitions with a for loop

```hcl
locals {
  guest_config_prereqs = [
    "add_system_identity_when_none_prerequisite",
    "add_system_identity_when_user_prerequisite",
    "deploy_extension_linux_prerequisite",
    "deploy_extension_windows_prerequisite",
  ]
}

module guest_config_prereqs {
  source                = "..//modules/definition"
  for_each              = toset(local.guest_config_prereqs)
  policy_name           = each.value
  policy_category       = "Guest Configuration"
  management_group_id   = data.azurerm_management_group.org.id
}

module guest_config_prereqs_initiative {
  source                  = "..//modules/initiative"
  initiative_name         = "guest_config_prereqs_initiative"
  initiative_display_name = "[GC]: Deploys Guest Config Prerequisites"
  initiative_description  = "Deploys and configures Windows and Linux VM Guest Config Prerequisites"
  initiative_category     = "Guest Configuration"
  management_group_id     = data.azurerm_management_group.org.id

  member_definitions = [
    for gcp in module.guest_config_prereqs :
    gcp.definition
  ]
}
```
