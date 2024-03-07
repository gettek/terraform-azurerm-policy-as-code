<!-- BEGIN_TF_DOCS -->
# POLICY INITIATIVE MODULE

Dynamically creates a policy set based on multiple custom or built-in policy definitions

> ⚠️ **Warning:** To simplify assignments, if any `member_definitions` contain the same parameter names they will be [merged](https://www.terraform.io/language/functions/merge) unless you specify `merge_effects = false` or `merge_parameters = false` as described in the third example below. When `false` parameters will be suffixed with their respective reference Ids e.g. `"effect_AutoEnrollSubscriptions"`.

## Examples

### Create an Initiative with duplicate member definitions

In many cases, some initiatives such as those for tagging, may need to reuse the same definition multiple times but with different parameters to simplify assignments.

Please see [duplicate_members.tf](../../examples/duplicate_members.tf) as en example use case.

> 💡 **Note:** you must set `duplicate_members=true` and `merge_parameters=false` when building initiatives with duplicate members.</br>
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

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.4 |
| azurerm | >=3.23.0 |



## Resources

| Name | Type |
|------|------|
| [azurerm_policy_set_definition.set](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/policy_set_definition) | resource |
| [terraform_data.set_replace](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/resources/data) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| duplicate_members | Does the Initiative contain duplicate member definitions? Defaults to false | `bool` | `false` | no |
| initiative_category | The category of the initiative | `string` | `"General"` | no |
| initiative_description | Policy initiative description | `string` | `""` | no |
| initiative_display_name | Policy initiative display name | `string` | n/a | yes |
| initiative_metadata | The metadata for the policy initiative. This is a JSON object representing additional metadata that should be stored with the policy initiative. Omitting this will default to merge var.initiative_category and var.initiative_version | `any` | `null` | no |
| initiative_name | Policy initiative name. Changing this forces a new resource to be created | `string` | n/a | yes |
| initiative_version | The version for this initiative, defaults to 1.0.0 | `string` | `"1.0.0"` | no |
| management_group_id | The management group scope at which the initiative will be defined. Defaults to current Subscription if omitted. Changing this forces a new resource to be created. Note: if you are using azurerm_management_group to assign a value to management_group_id, be sure to use name or group_id attribute, but not id. | `string` | `null` | no |
| member_definitions | Policy Definition resource nodes that will be members of this initiative | `any` | n/a | yes |
| merge_effects | Should the module merge all member definition effects? Defaults to true | `bool` | `true` | no |
| merge_parameters | Should the module merge all member definition parameters? Defaults to true | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The Id of the Policy Set Definition |
| initiative | The combined Policy Initiative resource node |
| metadata | The metadata of the Policy Set Definition |
| name | The name of the Policy Set Definition |
| non_compliance_messages | Generated Key/Value map of non-compliance messages |
| parameters | The combined parameters of the Policy Set Definition |
| role_definition_ids | Role definition IDs for remediation |
<!-- END_TF_DOCS -->