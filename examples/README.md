<!-- BEGIN_TF_DOCS -->
# Azure Policy Deployments

This examples folder demonstrates an effective deployment of Azure Policy Definitions and Assignments. The order of execution is generally from `definitions.tf` -> `initiatives.tf` -> `assignments_<scope>.tf` -> `exemptions.tf`

> 💡 **Note:** `built-in.tf` demonstrates how to assign Built-In definitions.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.4 |
| azuread | >= 2.45 |
| azurerm | >= 4.12 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| configure_asc | ..//modules/definition | n/a |
| configure_asc_initiative | ..//modules/initiative | n/a |
| deny_nic_public_ip | ..//modules/definition | n/a |
| deny_resource_types | ..//modules/definition | n/a |
| deploy_resource_diagnostic_setting | ..//modules/definition | n/a |
| exemption_subscription_diagnostics_settings | ..//modules/exemption | n/a |
| file_path_test | ..//modules/definition | n/a |
| inherit_resource_group_tags_modify | ..//modules/definition | n/a |
| org_mg_configure_asc_initiative | ..//modules/set_assignment | n/a |
| org_mg_configure_az_monitor_and_security_vm_initiative | ..//modules/set_assignment | n/a |
| org_mg_platform_diagnostics_initiative | ..//modules/set_assignment | n/a |
| org_mg_storage_enforce_https | ..//modules/def_assignment | n/a |
| org_mg_storage_enforce_minimum_tls1_2 | ..//modules/def_assignment | n/a |
| org_mg_whitelist_regions | ..//modules/def_assignment | n/a |
| parameterised_test | ..//modules/definition | n/a |
| platform_diagnostics_initiative | ..//modules/initiative | n/a |
| require_resource_group_tags | ..//modules/definition | n/a |
| resource_group_tags | ..//modules/initiative | n/a |
| storage_enforce_https | ..//modules/definition | n/a |
| storage_enforce_minimum_tls1_2 | ..//modules/definition | n/a |
| team_a_mg_deny_nic_public_ip | ..//modules/def_assignment | n/a |
| team_a_mg_deny_resource_types | ..//modules/def_assignment | n/a |
| team_a_mg_resource_group_tags | ..//modules/set_assignment | n/a |
| whitelist_regions | ..//modules/definition | n/a |

## Resources

| Name | Type |
|------|------|
| [azuread_group.rem](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_management_group.org](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/management_group) | data source |
| [azurerm_management_group.team_a](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/management_group) | data source |
| [azurerm_policy_set_definition.configure_az_monitor_and_security_vm_initiative](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/policy_set_definition) | data source |
| [azurerm_role_definition.contributor](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/role_definition) | data source |
| [azurerm_role_definition.vm_contributor](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/role_definition) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |
| [azurerm_user_assigned_identity.policy_rem](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/user_assigned_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| re_evaluate_compliance | Should the module re-evaluate compliant resources for policies that DeployIfNotExists and Modify | `bool` | `false` | no |
| skip_remediation | Skip creation of all remediation tasks for policies that DeployIfNotExists and Modify | `bool` | `false` | no |
| skip_role_assignment | Should the module skip creation of role assignment for policies that DeployIfNotExists and Modify | `bool` | `false` | no |


<!-- END_TF_DOCS -->