# Azure Policy Deployments

This examples folder demonstrates an effective deployment of Azure Policy Definitions and Assignments. The order of execution is generally from `definitions.tf` -> `initiatives.tf` -> `assignments_<scope>.tf` -> `exemptions.tf`

> 💡 **Note:** `built-in.tf` demonstrates how to assign Built-In definitions.


## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=3.23.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.23.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_configure_asc"></a> [configure\_asc](#module\_configure\_asc) | ..//modules/definition | n/a |
| <a name="module_configure_asc_initiative"></a> [configure\_asc\_initiative](#module\_configure\_asc\_initiative) | ..//modules/initiative | n/a |
| <a name="module_deny_nic_public_ip"></a> [deny\_nic\_public\_ip](#module\_deny\_nic\_public\_ip) | ..//modules/definition | n/a |
| <a name="module_deny_resources_types"></a> [deny\_resources\_types](#module\_deny\_resources\_types) | ..//modules/definition | n/a |
| <a name="module_deploy_resource_diagnostic_setting"></a> [deploy\_resource\_diagnostic\_setting](#module\_deploy\_resource\_diagnostic\_setting) | ..//modules/definition | n/a |
| <a name="module_exemption_subscription_diagnostics_settings"></a> [exemption\_subscription\_diagnostics\_settings](#module\_exemption\_subscription\_diagnostics\_settings) | ..//modules/exemption | n/a |
| <a name="module_inherit_resource_group_tags_modify"></a> [inherit\_resource\_group\_tags\_modify](#module\_inherit\_resource\_group\_tags\_modify) | ..//modules/definition | n/a |
| <a name="module_org_mg_configure_asc_initiative"></a> [org\_mg\_configure\_asc\_initiative](#module\_org\_mg\_configure\_asc\_initiative) | ..//modules/set_assignment | n/a |
| <a name="module_org_mg_configure_az_monitor_and_security_vm_initiative"></a> [org\_mg\_configure\_az\_monitor\_and\_security\_vm\_initiative](#module\_org\_mg\_configure\_az\_monitor\_and\_security\_vm\_initiative) | ..//modules/set_assignment | n/a |
| <a name="module_org_mg_platform_diagnostics_initiative"></a> [org\_mg\_platform\_diagnostics\_initiative](#module\_org\_mg\_platform\_diagnostics\_initiative) | ..//modules/set_assignment | n/a |
| <a name="module_org_mg_storage_enforce_https"></a> [org\_mg\_storage\_enforce\_https](#module\_org\_mg\_storage\_enforce\_https) | ..//modules/def_assignment | n/a |
| <a name="module_org_mg_storage_enforce_minimum_tls1_2"></a> [org\_mg\_storage\_enforce\_minimum\_tls1\_2](#module\_org\_mg\_storage\_enforce\_minimum\_tls1\_2) | ..//modules/def_assignment | n/a |
| <a name="module_org_mg_whitelist_regions"></a> [org\_mg\_whitelist\_regions](#module\_org\_mg\_whitelist\_regions) | ..//modules/def_assignment | n/a |
| <a name="module_platform_diagnostics_initiative"></a> [platform\_diagnostics\_initiative](#module\_platform\_diagnostics\_initiative) | ..//modules/initiative | n/a |
| <a name="module_storage_enforce_https"></a> [storage\_enforce\_https](#module\_storage\_enforce\_https) | ..//modules/definition | n/a |
| <a name="module_storage_enforce_minimum_tls1_2"></a> [storage\_enforce\_minimum\_tls1\_2](#module\_storage\_enforce\_minimum\_tls1\_2) | ..//modules/definition | n/a |
| <a name="module_team_a_mg_deny_nic_public_ip"></a> [team\_a\_mg\_deny\_nic\_public\_ip](#module\_team\_a\_mg\_deny\_nic\_public\_ip) | ..//modules/def_assignment | n/a |
| <a name="module_team_a_mg_deny_resources_types"></a> [team\_a\_mg\_deny\_resources\_types](#module\_team\_a\_mg\_deny\_resources\_types) | ..//modules/def_assignment | n/a |
| <a name="module_team_a_mg_inherit_resource_group_tags_modify"></a> [team\_a\_mg\_inherit\_resource\_group\_tags\_modify](#module\_team\_a\_mg\_inherit\_resource\_group\_tags\_modify) | ..//modules/def_assignment | n/a |
| <a name="module_whitelist_regions"></a> [whitelist\_regions](#module\_whitelist\_regions) | ..//modules/definition | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_management_group.org](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/management_group) | data source |
| [azurerm_management_group.team_a](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/management_group) | data source |
| [azurerm_policy_set_definition.configure_az_monitor_and_security_vm_initiative](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/policy_set_definition) | data source |
| [azurerm_role_definition.contributor](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/role_definition) | data source |
| [azurerm_role_definition.vm_contributor](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/role_definition) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_skip_remediation"></a> [skip\_remediation](#input\_skip\_remediation) | Skip creation of all remediation tasks for policies that DeployIfNotExists and Modify | `bool` | `false` | no |
| <a name="input_skip_role_assignment"></a> [skip\_role\_assignment](#input\_skip\_role\_assignment) | Should the module skip creation of role assignment for policies that DeployIfNotExists and Modify | `bool` | `false` | no |

## Outputs

No outputs.
