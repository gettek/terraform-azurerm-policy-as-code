# POLICY EXEMPTION MODULE

Exemptions can be used where `not_scopes` become time sensitive or require alternative methods of approval for audit trails. Learn more about Azure Policy [exemption structure](https://docs.microsoft.com/en-us/azure/governance/policy/concepts/exemption-structure).

## Examples

### At Management Group Scope with Optional Metadata

```hcl
module exemption_team_a_mg_deny_nic_public_ip {
  source   = "gettek/policy-as-code/azurerm//modules/exemption"
  name                            = "Deny NIC Public IP Exemption"
  display_name                    = "Exempted for testing"
  description                     = "Allows NIC Public IPs for testing"
  scope                           = data.azurerm_management_group.team_a.id
  policy_assignment_id            = module.team_a_mg_deny_nic_public_ip.id
  exemption_category              = "Waiver"
  expires_on                      = "2023-05-25"

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

```hcl
module "exemption_configure_asc_initiative" {
  source                          = "gettek/policy-as-code/azurerm//modules/exemption"
  name                            = "Onboard subscription to ASC Exemption"
  display_name                    = "Exempted while testing"
  description                     = "Excludes subscription from ASC onboarding during development"
  scope                           = "/subscriptions/${var.team_a_subscription_id}"
  policy_assignment_id            = module.org_mg_configure_asc_initiative.id
  policy_definition_reference_ids = [
    "6d237bfef483fbb3308d",
    "652d1284813c442a7e95"
  ]
}
```

### Resource Group Exemption

```hcl
data azurerm_resource_group vms {
  name = "rg-dev-uks-vms"
}

module exemption_team_a_mg_deny_nic_public_ip {
  source   = "gettek/policy-as-code/azurerm//modules/exemption"
  name                            = "Deny NIC Public IP Exemption"
  scope                           = data.azurerm_resource_group.vms.id
  policy_assignment_id            = module.team_a_mg_deny_nic_public_ip.id
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
  source               = "gettek/policy-as-code/azurerm//modules/exemption"
  for_each             = toset(data.azurerm_resources.keyvaults.resources.*.id)
  name                 = "Key vaults should have purge protection enabled Exemption"
  scope                = each.value
  policy_assignment_id = module.team_a_mg_key_vaults_require_purge_protection.id
  exemption_category   = "Mitigated"
  expires_on           = "2023-05-25"
  display_name         = "Exempted for testing"
  description          = "Do not require purge protection on KVs while testing"
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
| <a name="input_metadata"></a> [metadata](#input\_metadata) | Optional policy exemption metadata. For example but not limited to; requestedBy, approvedBy, approvedOn, ticketRef, etc | `any` | `{}` | no |
| <a name="input_name"></a> [name](#input\_name) | Name for the Policy Exemption | `string` | n/a | yes |
| <a name="input_policy_assignment_id"></a> [policy\_assignment\_id](#input\_policy\_assignment\_id) | The ID of the policy assignment that is being exempted | `string` | n/a | yes |
| <a name="input_policy_definition_reference_ids"></a> [policy\_definition\_reference\_ids](#input\_policy\_definition\_reference\_ids) | The policy definition reference ID list when the associated policy assignment is an assignment of a policy set definition | `list(any)` | `[]` | no |
| <a name="input_scope"></a> [scope](#input\_scope) | Scope for the Policy Exemption | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_exemption_resource_nodes"></a> [exemption\_resource\_nodes](#output\_exemption\_resource\_nodes) | The Policy Exemption resource node(s) |
| <a name="output_id"></a> [id](#output\_id) | The Id of the Policy Exemption |
