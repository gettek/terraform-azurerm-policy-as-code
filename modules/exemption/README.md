# POLICY EXEMPTION MODULE

Exemptions can be used where `not_scopes` become time sensitive or require alternative methods of approval for audit trails. Learn more about Azure Policy [exemption structure](https://docs.microsoft.com/en-us/azure/governance/policy/concepts/exemption-structure).

> 💡**Note:** This module also allows you to exempt multiple scope types at once (e.g. resource group and individual resource) when using a `for_each` loop as in the example below.

## Examples

### At Management Group Scope with Optional Metadata

```hcl
module exemption_team_a_mg_deny_nic_public_ip {
  source               = "gettek/policy-as-code/azurerm//modules/exemption"
  name                 = "Deny NIC Public IP Exemption"
  display_name         = "Exempted while testing"
  description          = "Allows NIC Public IPs for testing"
  scope                = data.azurerm_management_group.team_a.id
  policy_assignment_id = module.team_a_mg_deny_nic_public_ip.id
  exemption_category   = "Waiver"
  expires_on           = "2023-05-25"

  # optional metadata, these can consist of any key/value pairs, or omit to have none
  metadata = {
    requested_by  = "Team A"
    approved_by   = "Mr Smith"
    approved_date = "2021-11-30"
    ticket_ref    = "1923"
  }
}
```

### Exempt multiple scope types in a for_each loop

```hcl
module exemption_team_a_mg_deny_nic_public_ip {
  source = "gettek/policy-as-code/azurerm//modules/exemption"
  for_each = toset([
    data.azurerm_management_group.team_a.id,
    data.azurerm_subscription.current.id,
    data.azurerm_resource_group.example.id
    data.azurerm_network_interface.example.id
  ])
  name                 = "Deny NIC Public IP Exemption"
  display_name         = "Exempted while testing"
  description          = "Allows NIC Public IPs for testing"
  scope                = each.value
  policy_assignment_id = module.team_a_mg_deny_nic_public_ip.id
}
```

### Exempt a subset of definitions within an Initiative at Subscription Scope

```hcl
module "exemption_configure_asc_initiative" {
  source                          = "gettek/policy-as-code/azurerm//modules/exemption"
  name                            = "Onboard subscription to ASC Exemption"
  display_name                    = "Exempted while testing"
  description                     = "Excludes subscription from ASC onboarding during development"
  scope                           = data.azurerm_subscription.current.id
  policy_assignment_id            = module.org_mg_configure_asc_initiative.id
  member_definition_names = [
    "auto_provision_log_analytics_agent_custom_workspace",
    "auto_set_contact_details"
  ]
}
```

### Resource Group Exemption

```hcl
module exemption_team_a_mg_deny_nic_public_ip {
  source               = "gettek/policy-as-code/azurerm//modules/exemption"
  name                 = "Deny NIC Public IP Exemption"
  display_name         = "Exempted while testing"
  description          = "Allows NIC Public IPs for testing"
  scope                = data.azurerm_resource_group.example.id
  policy_assignment_id = module.team_a_mg_deny_nic_public_ip.id
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
  source               = "gettek/policy-as-code/azurerm//modules/exemption"
  for_each             = toset(data.azurerm_resources.keyvaults.resources.*.id)
  name                 = "Key vaults should have purge protection enabled Exemption"
  display_name         = "Exempted while testing"
  description          = "Do not require purge protection on KVs while testing"
  scope                = each.value
  policy_assignment_id = module.team_a_mg_key_vaults_require_purge_protection.id
  exemption_category   = "Mitigated"
  expires_on           = "2023-05-25"
}
```


## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=3.2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >=3.2.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_management_group_policy_exemption.management_group_exemption](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group_policy_exemption) | resource |
| [azurerm_resource_group_policy_exemption.resource_group_exemption](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group_policy_exemption) | resource |
| [azurerm_resource_policy_exemption.resource_exemption](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_policy_exemption) | resource |
| [azurerm_subscription_policy_exemption.subscription_exemption](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subscription_policy_exemption) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | Description for the Policy Exemption | `string` | n/a | yes |
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | Display name for the Policy Exemption | `string` | n/a | yes |
| <a name="input_exemption_category"></a> [exemption\_category](#input\_exemption\_category) | The policy exemption category. Possible values are Waiver or Mitigated. Defaults to Waiver | `string` | `"Waiver"` | no |
| <a name="input_expires_on"></a> [expires\_on](#input\_expires\_on) | Optional expiration date (format yyyy-mm-dd) of the policy exemption. Defaults to no expiry | `string` | `null` | no |
| <a name="input_member_definition_names"></a> [member\_definition\_names](#input\_member\_definition\_names) | Generate the definition reference Ids from the member definition names when 'policy\_definition\_reference\_ids' are unknown. Ommit to exempt all member definitions | `list(string)` | `[]` | no |
| <a name="input_metadata"></a> [metadata](#input\_metadata) | Optional policy exemption metadata. For example but not limited to; requestedBy, approvedBy, approvedOn, ticketRef, etc | `any` | `{}` | no |
| <a name="input_name"></a> [name](#input\_name) | Name for the Policy Exemption | `string` | n/a | yes |
| <a name="input_policy_assignment_id"></a> [policy\_assignment\_id](#input\_policy\_assignment\_id) | The ID of the policy assignment that is being exempted | `string` | n/a | yes |
| <a name="input_policy_definition_reference_ids"></a> [policy\_definition\_reference\_ids](#input\_policy\_definition\_reference\_ids) | The optional policy definition reference ID list when the associated policy assignment is an assignment of a policy set definition. Ommit to exempt all member definitions | `list(string)` | `[]` | no |
| <a name="input_scope"></a> [scope](#input\_scope) | Scope for the Policy Exemption | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The Id of the Policy Exemption |
