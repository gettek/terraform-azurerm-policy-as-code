# BUILTIN POLICY MODULE

This module depends on populating `var.display_name` to correspond with the respective Built-In Policy definition in Azure.

> 💡 **Note:** More information on Policy Definition Structure [can be found here](https://docs.microsoft.com/en-us/azure/governance/policy/concepts/definition-structure)

## Examples

### Get Policy Definition from terraform data source

```hcl
module "builtin_policy" {
  source      = "gettek/policy-as-code/azurerm//modules/builtin_policy"
  policy_name = "Allowed locations"
}

```

### Loop around a map to quickly get multiple definitions

```hcl
locals {
  corp_policies = [
    // MFA
    "MFA should be enabled on accounts with owner permissions on your subscription",
    "MFA should be enabled accounts with write permissions on your subscription",
    // Location
    "Allowed locations",
    "Allowed locations for resource groups",
  ]
}

module "builtin_policies" {
  source      = "gettek/policy-as-code/azurerm//modules/builtin_policy"
  for_each    = toset(local.corp_policies)
  policy_name = each.value
}

```

### Use received data to be used in Initiative Definition

```hcl
module "corp_def_initiative" {
  source                  = "gettek/policy-as-code/azurerm//modules/initiative"
  initiative_name         = "corp_def_initiative"
  initiative_display_name = "[corp] Initiative assignment"
  initiative_description  = "Deploys and configures policies for corp Management Group"
  initiative_category     = "General"
  management_group_id     = data.azurerm_management_group.corp.id

  # Populate member_definitions with a for loop (explicit)
  member_definitions = [
    for policy in local.corp_policies : module.builtin_policies[policy].definition
  ]
}
```
