# POLICY INITIATIVE MODULE

Dynamically creates a policy set based on multiple custom or built-in policy definition references

> ⚠️ **Warning:** If any two `member_definition_ids` contain the same parameters then they will be [merged](https://www.terraform.io/language/functions/merge) by this module (except for `"effect"` when setting `merge_effects = false`) [as seen here](variables.tf#L74-L81). In most cases this is beneficial but if unique values are required it may be best practice to set unique keys directly within your custom definition.json files such as `[parameters('listOfResourceTypesAllowed_WhitelistResources')]` instead of `[parameters('listOfResourceTypesAllowed')]`.


## Examples

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

When setting `merge_effects = false` the module will suffix each definition effect parameter with its respective policy definition reference Id e.g. `"effect_AutoEnrollSubscriptions"`.

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
```

### Populate member_definitions with a for loop (not explicit)

```hcl
locals {
  guest_config_prereqs = [
    "add_system_identity_when_none_prerequisite",
    "add_system_identity_when_user_prerequisite",
    "deploy_extension_linux_prerequisite",
    "deploy_extension_windows_prerequisite",
  ]
}

module "guest_config_prereqs" {
  source                = "..//modules/definition"
  for_each              = toset(local.guest_config_prereqs)
  policy_name           = each.value
  policy_category       = "Guest Configuration"
  management_group_id   = data.azurerm_management_group.org.id
}

module "guest_config_prereqs_initiative" {
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
