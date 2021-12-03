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

## Examples

### At Management Group Scope

```hcl
module exemption_customer_mg_deny_nic_public_ip {
  source   = "gettek/policy-as-code/azurerm//modules/exemption"
  name                            = "Deny NIC Public IP Exemption"
  scope                           = data.azurerm_management_group.team_a.id # should be management_group_id not name
  policy_assignment_id            = module.customer_mg_deny_nic_public_ip.id
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
data azurerm_resource_group vaults {
  name = "rg-dev-uks-vaults"
}

module exemption_customer_mg_deny_nic_public_ip {
  source   = "gettek/policy-as-code/azurerm//modules/exemption"
  providers = {
    azurerm = azurerm.team_a
  }
  name                            = "Deny NIC Public IP Exemption"
  scope                           = data.azurerm_resource_group.vaults
  policy_assignment_id            = module.customer_mg_deny_nic_public_ip.id
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

module exemption_customer_mg_deny_nic_public_ip {
  source   = "gettek/policy-as-code/azurerm//modules/exemption"
  for_each = toset(data.azurerm_resources.keyvaults.resources.*.id)
  providers = {
    azurerm = azurerm.team_a
  }
  name                            = "Deny NIC Public IP Exemption"
  scope                           = each.value
  policy_assignment_id            = module.customer_mg_deny_nic_public_ip.id
  exemption_category              = "Waiver"
  expires_on                      = "2022-05-31"
  display_name                    = "Exempted for testing"
  description                     = "Allows NIC Public IPs for testing"
}
```


## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_management_group_template_deployment.management_group_exemption](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group_template_deployment) | resource |
| [azurerm_resource_group_template_deployment.resource_exemption](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group_template_deployment) | resource |
| [azurerm_resource_group_template_deployment.resource_group_exemption](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group_template_deployment) | resource |
| [azurerm_subscription_template_deployment.subscription_exemption](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subscription_template_deployment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | Description for the Policy Exemption | `string` | n/a | yes |
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | Display name for the Policy Exemption | `string` | n/a | yes |
| <a name="input_exemption_category"></a> [exemption\_category](#input\_exemption\_category) | The policy exemption category. Possible values are Waiver and Mitigated. Defaults to Waiver | `string` | `"Waiver"` | no |
| <a name="input_expires_on"></a> [expires\_on](#input\_expires\_on) | The expiration date and time (in UTC ISO 8601 format yyyy-MM-ddTHH:mm:ssZ) of the policy exemption | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The Azure Region where the Management Group or Subscription Scope Template Deployment should exist. Changing this forces a new Template to be created. Defaults to UK South | `string` | `"uksouth"` | no |
| <a name="input_metadata"></a> [metadata](#input\_metadata) | Optional policy exemption metadata. For example but not limited to; requestedBy, approvedBy, approvedOn, ticketRef, etc | `any` | `{}` | no |
| <a name="input_name"></a> [name](#input\_name) | Name for the Policy Exemption | `string` | n/a | yes |
| <a name="input_policy_assignment_id"></a> [policy\_assignment\_id](#input\_policy\_assignment\_id) | The ID of the policy assignment that is being exempted | `string` | n/a | yes |
| <a name="input_policy_definition_reference_ids"></a> [policy\_definition\_reference\_ids](#input\_policy\_definition\_reference\_ids) | The policy definition reference ID list when the associated policy assignment is an assignment of a policy set definition | `list` | `[]` | no |
| <a name="input_scope"></a> [scope](#input\_scope) | Scope for the Policy Exemption | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The Id of the Policy Exemption |
| <a name="output_output_content"></a> [output\_content](#output\_output\_content) | The Content of the Outputs of the ARM Template Deployment |
