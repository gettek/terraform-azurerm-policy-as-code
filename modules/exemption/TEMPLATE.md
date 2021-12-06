# POLICY EXEMPTION MODULE

Exemptions can be used where `not_scopes` become time sensitive or require alternative methods of approval for audit trails. Learn more about Azure Policy [exemption structure](https://docs.microsoft.com/en-us/azure/governance/policy/concepts/exemption-structure).

This module creates a policy exemption rule at multiple scopes using `azurerm_resource_group_template_deployment` until the terraform community release a native provider resource. Using the value(s) passed into the `scope` variable one of the below resources will be deployed:

```hcl
# Exemption at Management Group Scope:
resource.azurerm_management_group_template_deployment.management_group_exemption

# Exemption at Subscription Scope:
resource.azurerm_subscription_template_deployment.subscription_exemption

# Exemption at Resource Group Scope
resource.azurerm_resource_group_template_deployment.resource_group_exemption

# Exemption at Resource Scope:
resource.azurerm_resource_group_template_deployment.resource_exemption
```

> 💡 azurerm_resource_group_template_deployment resource will automatically attempt to delete resources deployed by the ARM Template when it is deleted. This behaviour can be disabled in the provider `features` block by setting the `delete_nested_items_during_deletion` field to `false` within the `template_deployment` block.

## Examples

### At Management Group Scope

```hcl
module exemption_team_a_mg_deny_nic_public_ip {
  source   = "gettek/policy-as-code/azurerm//modules/exemption"
  name                            = "Deny NIC Public IP Exemption"
  scope                           = data.azurerm_management_group.team_a.id # should be management_group_id not name
  policy_assignment_id            = module.team_a_mg_deny_nic_public_ip.id
  exemption_category              = "Waiver"
  expires_on                      = "2022-05-31"
  display_name                    = "Exempted for testing"
  description                     = "Allows NIC Public IPs for testing"
  
  # optional metadata, these can consist of any key/value pairs, or omit to have none
  metadata = {
    requested_by  = "Team A"
    approved_by   = "Mr Smith"
    approved_date = "2021-11-30"
    ticket_ref    = "1923"
  }
}
```

### Exempt a subset of definitions within an Initiative at Subscription Scope

Note: the `scope` variable can be omitted for subscription exemptions as it defaults to the id assigned to the `providers {}` block:

```hcl
module "exemption_configure_asc_initiative" {
  source   = "gettek/policy-as-code/azurerm//modules/exemption"
  providers = {
    azurerm = azurerm.team_a
  }
  name                            = "Onboard subscription to ASC Exemption"
  scope                           = "/subscriptions/${var.team_a_subscription_id}"
  policy_assignment_id            = module.org_mg_configure_asc_initiative.id
  policy_definition_reference_ids = [
    "6d237bfef483fbb3308d",
    "652d1284813c442a7e95"
  ]
  exemption_category              = "Waiver"
  expires_on                      = "2022-05-31"
  display_name                    = "Exempted while testing"
  description                     = "Excludes subscription from ASC onboarding during development"
}
```

### Resource Group Exemption

```hcl
data azurerm_resource_group vms {
  name = "rg-dev-uks-vms"
}

module exemption_team_a_mg_deny_nic_public_ip {
  source   = "gettek/policy-as-code/azurerm//modules/exemption"
  providers = {
    azurerm = azurerm.team_a
  }
  name                            = "Deny NIC Public IP Exemption"
  scope                           = data.azurerm_resource_group.vms
  policy_assignment_id            = module.team_a_mg_deny_nic_public_ip.id
  exemption_category              = "Waiver"
  expires_on                      = "2022-05-31"
  display_name                    = "Exempted for testing"
  description                     = "Allows NIC Public IPs for testing"
}
```

### Multiple Resource exemptions for all KeyVaults in a Resource Group

Use `azurerm_resources` to retrieve a list of resource types within the same resource group or specify a simpler (more declarative) array of your choosing.

```hcl
data azurerm_resources keyvaults {
  type                = "Microsoft.KeyVault/vaults"
  resource_group_name = "rg-dev-uks-vaults"
}

module exemption_team_a_mg_key_vaults_require_purge_protection {
  source   = "gettek/policy-as-code/azurerm//modules/exemption"
  for_each = toset(data.azurerm_resources.keyvaults.resources.*.id)
  providers = {
    azurerm = azurerm.team_a
  }
  name                            = "Key vaults should have purge protection enabled Exemption"
  scope                           = each.value
  policy_assignment_id            = module.team_a_mg_key_vaults_require_purge_protection.id
  exemption_category              = "Waiver"
  expires_on                      = "2022-05-31"
  display_name                    = "Exempted for testing"
  description                     = "Do not require purge protection on KVs while testing"
}
```
