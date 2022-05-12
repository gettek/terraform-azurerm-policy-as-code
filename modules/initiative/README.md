# POLICY INITIATIVE MODULE

Dynamically creates a policy set based on multiple policy definition references


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

### Create an Initiative with a mix of custom & built-in Policy definitions

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
| [azurerm_policy_set_definition.set](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/policy_set_definition) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_initiative_category"></a> [initiative\_category](#input\_initiative\_category) | The category of the initiative | `string` | `"General"` | no |
| <a name="input_initiative_description"></a> [initiative\_description](#input\_initiative\_description) | Policy initiative description | `string` | `""` | no |
| <a name="input_initiative_display_name"></a> [initiative\_display\_name](#input\_initiative\_display\_name) | Policy initiative display name | `string` | n/a | yes |
| <a name="input_initiative_name"></a> [initiative\_name](#input\_initiative\_name) | Policy initiative name. Changing this forces a new resource to be created | `string` | n/a | yes |
| <a name="input_initiative_version"></a> [initiative\_version](#input\_initiative\_version) | The version for this initiative, defaults to 1.0.0 | `string` | `"1.0.0"` | no |
| <a name="input_management_group_id"></a> [management\_group\_id](#input\_management\_group\_id) | The management group scope at which the initiative will be defined. Defaults to current Subscription if omitted. Changing this forces a new resource to be created. Note: if you are using azurerm\_management\_group to assign a value to management\_group\_id, be sure to use name or group\_id attribute, but not id. | `string` | `null` | no |
| <a name="input_member_definitions"></a> [member\_definitions](#input\_member\_definitions) | Policy Defenition resource nodes that will be members of this initiative | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The Id of the Policy Set Definition |
| <a name="output_initiative"></a> [initiative](#output\_initiative) | The combined Policy Initiative resource node |
| <a name="output_metadata"></a> [metadata](#output\_metadata) | The metadata of the Policy Set Definition |
| <a name="output_name"></a> [name](#output\_name) | The name of the Policy Set Definition |
| <a name="output_parameters"></a> [parameters](#output\_parameters) | The combined parameters of the Policy Set Definition |
| <a name="output_role_definition_ids"></a> [role\_definition\_ids](#output\_role\_definition\_ids) | Role definition IDs for remediation |
