# Azure Policy Deployments

This examples folder demonstrates an effective deployment of Azure Policy Definitions and Assignments. The order of execution is generally from `definitions.tf` -> `initiatives.tf` -> `assignments_<scope>.tf`


## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 2.84.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_add_replace_resource_group_tag_key_modify"></a> [add\_replace\_resource\_group\_tag\_key\_modify](#module\_add\_replace\_resource\_group\_tag\_key\_modify) | ..//modules/definition | n/a |
| <a name="module_audit_log_analytics_workspace_retention"></a> [audit\_log\_analytics\_workspace\_retention](#module\_audit\_log\_analytics\_workspace\_retention) | ..//modules/definition | n/a |
| <a name="module_cis_custom_benchmark"></a> [cis\_custom\_benchmark](#module\_cis\_custom\_benchmark) | ..//modules/cis_benchmark | n/a |
| <a name="module_configure_asc"></a> [configure\_asc](#module\_configure\_asc) | ..//modules/definition | n/a |
| <a name="module_configure_asc_initiative"></a> [configure\_asc\_initiative](#module\_configure\_asc\_initiative) | ..//modules/initiative | n/a |
| <a name="module_create_nsg_rule_append"></a> [create\_nsg\_rule\_append](#module\_create\_nsg\_rule\_append) | ..//modules/definition | n/a |
| <a name="module_customer_mg_add_replace_resource_group_tag_key_modify"></a> [customer\_mg\_add\_replace\_resource\_group\_tag\_key\_modify](#module\_customer\_mg\_add\_replace\_resource\_group\_tag\_key\_modify) | ..//modules/def_assignment | n/a |
| <a name="module_customer_mg_deny_nic_public_ip"></a> [customer\_mg\_deny\_nic\_public\_ip](#module\_customer\_mg\_deny\_nic\_public\_ip) | ..//modules/def_assignment | n/a |
| <a name="module_customer_mg_deny_nsg_outbound_allow_all"></a> [customer\_mg\_deny\_nsg\_outbound\_allow\_all](#module\_customer\_mg\_deny\_nsg\_outbound\_allow\_all) | ..//modules/def_assignment | n/a |
| <a name="module_customer_mg_inherit_resource_group_tags_modify"></a> [customer\_mg\_inherit\_resource\_group\_tags\_modify](#module\_customer\_mg\_inherit\_resource\_group\_tags\_modify) | ..//modules/def_assignment | n/a |
| <a name="module_customer_mg_whitelist_resources"></a> [customer\_mg\_whitelist\_resources](#module\_customer\_mg\_whitelist\_resources) | ..//modules/def_assignment | n/a |
| <a name="module_deny_nat_rules_firewalls"></a> [deny\_nat\_rules\_firewalls](#module\_deny\_nat\_rules\_firewalls) | ..//modules/definition | n/a |
| <a name="module_deny_nic_public_ip"></a> [deny\_nic\_public\_ip](#module\_deny\_nic\_public\_ip) | ..//modules/definition | n/a |
| <a name="module_deny_nic_public_ip_on_specific_subnets"></a> [deny\_nic\_public\_ip\_on\_specific\_subnets](#module\_deny\_nic\_public\_ip\_on\_specific\_subnets) | ..//modules/definition | n/a |
| <a name="module_deny_nsg_outbound_allow_all"></a> [deny\_nsg\_outbound\_allow\_all](#module\_deny\_nsg\_outbound\_allow\_all) | ..//modules/definition | n/a |
| <a name="module_deny_pip_authorised_resources"></a> [deny\_pip\_authorised\_resources](#module\_deny\_pip\_authorised\_resources) | ..//modules/definition | n/a |
| <a name="module_deploy_resource_diagnostic_setting"></a> [deploy\_resource\_diagnostic\_setting](#module\_deploy\_resource\_diagnostic\_setting) | ..//modules/definition | n/a |
| <a name="module_deploy_subscription_diagnostic_setting"></a> [deploy\_subscription\_diagnostic\_setting](#module\_deploy\_subscription\_diagnostic\_setting) | ..//modules/definition | n/a |
| <a name="module_inherit_resource_group_tags_modify"></a> [inherit\_resource\_group\_tags\_modify](#module\_inherit\_resource\_group\_tags\_modify) | ..//modules/definition | n/a |
| <a name="module_org_mg_cis_custom_benchmark"></a> [org\_mg\_cis\_custom\_benchmark](#module\_org\_mg\_cis\_custom\_benchmark) | ..//modules/set_assignment | n/a |
| <a name="module_org_mg_configure_asc_initiative"></a> [org\_mg\_configure\_asc\_initiative](#module\_org\_mg\_configure\_asc\_initiative) | ..//modules/set_assignment | n/a |
| <a name="module_org_mg_network_deny_nat_rules_firewall"></a> [org\_mg\_network\_deny\_nat\_rules\_firewall](#module\_org\_mg\_network\_deny\_nat\_rules\_firewall) | ..//modules/def_assignment | n/a |
| <a name="module_org_mg_platform_diagnostics_initiative"></a> [org\_mg\_platform\_diagnostics\_initiative](#module\_org\_mg\_platform\_diagnostics\_initiative) | ..//modules/set_assignment | n/a |
| <a name="module_org_mg_storage_enforce_https"></a> [org\_mg\_storage\_enforce\_https](#module\_org\_mg\_storage\_enforce\_https) | ..//modules/def_assignment | n/a |
| <a name="module_org_mg_storage_enforce_minimum_tls1_2"></a> [org\_mg\_storage\_enforce\_minimum\_tls1\_2](#module\_org\_mg\_storage\_enforce\_minimum\_tls1\_2) | ..//modules/def_assignment | n/a |
| <a name="module_org_mg_whitelist_regions"></a> [org\_mg\_whitelist\_regions](#module\_org\_mg\_whitelist\_regions) | ..//modules/def_assignment | n/a |
| <a name="module_platform_diagnostics_initiative"></a> [platform\_diagnostics\_initiative](#module\_platform\_diagnostics\_initiative) | ..//modules/initiative | n/a |
| <a name="module_require_resource_group_tags"></a> [require\_resource\_group\_tags](#module\_require\_resource\_group\_tags) | ..//modules/definition | n/a |
| <a name="module_storage_enforce_https"></a> [storage\_enforce\_https](#module\_storage\_enforce\_https) | ..//modules/definition | n/a |
| <a name="module_storage_enforce_minimum_tls1_2"></a> [storage\_enforce\_minimum\_tls1\_2](#module\_storage\_enforce\_minimum\_tls1\_2) | ..//modules/definition | n/a |
| <a name="module_whitelist_regions"></a> [whitelist\_regions](#module\_whitelist\_regions) | ..//modules/definition | n/a |
| <a name="module_whitelist_resources"></a> [whitelist\_resources](#module\_whitelist\_resources) | ..//modules/definition | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_management_group.org](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/management_group) | data source |
| [azurerm_management_group.team_a](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/management_group) | data source |
| [azurerm_role_definition.contributor](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/role_definition) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_skip_remediation"></a> [skip\_remediation](#input\_skip\_remediation) | Skip creation of all remediation tasks for policies that DeployIfNotExists and Modify | `bool` | `false` | no |

## Outputs

No outputs.
