# Azure Policy Machine Configuration for Virtual Machines

[![cd-machine-config](https://github.com/gettek/terraform-azurerm-policy-as-code/actions/workflows/cd-guest-config.yml/badge.svg)](https://github.com/gettek/terraform-azurerm-policy-as-code/actions/workflows/cd-guest-config.yml)

This folder demonstrates an effective terraform workflow for continuous compliance with [Azure Policy Machine Configuration](https://learn.microsoft.com/en-us/azure/governance/machine-configuration/overview) (Uses PowerShell Desired State Config).

### Automating CGC Package Deployment

This example executes a terraform null resource to run the [build_machine_config_packages.ps1](../scripts/build_machine_config_packages.ps1) PowerShell script which builds and publishes Custom Machine Config (CGC) policy definitions, PS Module dependencies are installed with the `checkDependancies` flag.

On initial run or to rebuild/update existing configs, first target the null resource with parallelism set to 1 before running a complete apply such as below. This will prevent the [`GuestConfiguration`](https://www.powershellgallery.com/packages/GuestConfiguration/) PowerShell module from encountering conflicts during package creation. If the `checkDependancies` flag is unset each config should take approximately 10-15 seconds to publish packages and generate each Definition.

```bash
apply -target null_resource.build_machine_config_packages -parallelism=1 && tf apply
```

Definitions will stored in the local repo library under [Guest Configuration](../policies/Guest%20Configuration/)

> 💡 **Note:** see also [Terraform Provider: azurerm_policy_virtual_machine_configuration_assignment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/policy_virtual_machine_configuration_assignment)

### Links

- 📘 [Understand the machine configuration feature of Azure Automanage](https://learn.microsoft.com/en-us/azure/governance/machine-configuration/overview)
- 📘 [Azure Policy guest configuration extension](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/manage/azure-server-management/guest-configuration-policy)
- 📘 [Remediation options for machine configuration](https://learn.microsoft.com/en-us/azure/governance/machine-configuration/machine-configuration-policy-effects)
- 📘 [How to create custom machine configuration package artifacts](https://learn.microsoft.com/en-us/azure/governance/machine-configuration/machine-configuration-create)
- 📙 [DSC GitHub Community](https://github.com/dsccommunity)


## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.44.1 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.2.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_custom_guest_configs"></a> [custom\_guest\_configs](#module\_custom\_guest\_configs) | ..//modules/definition | n/a |
| <a name="module_custom_guest_configs_initiative"></a> [custom\_guest\_configs\_initiative](#module\_custom\_guest\_configs\_initiative) | ..//modules/initiative | n/a |
| <a name="module_team_a_mg_guest_config_prereqs_initiative"></a> [team\_a\_mg\_guest\_config\_prereqs\_initiative](#module\_team\_a\_mg\_guest\_config\_prereqs\_initiative) | ..//modules/set_assignment | n/a |
| <a name="module_team_a_mg_vm_custom_machine_configs"></a> [team\_a\_mg\_vm\_custom\_machine\_configs](#module\_team\_a\_mg\_vm\_custom\_machine\_configs) | ..//modules/set_assignment | n/a |

## Resources

| Name | Type |
|------|------|
| [null_resource.build_machine_config_packages](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_management_group.org](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/management_group) | data source |
| [azurerm_management_group.team_a](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/management_group) | data source |
| [azurerm_policy_set_definition.deploy_guest_config_prereqs_initiative](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/policy_set_definition) | data source |
| [azurerm_role_definition.contributor](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/role_definition) | data source |
| [azurerm_storage_container.guest_config_container](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_container) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_build_packages"></a> [build\_packages](#input\_build\_packages) | Create and publish custom machine config polices with build\_machine\_config\_packages.ps1 | `bool` | `true` | no |
| <a name="input_re_evaluate_compliance"></a> [re\_evaluate\_compliance](#input\_re\_evaluate\_compliance) | Should the module re-evaluate compliant resources for policies that DeployIfNotExists and Modify | `bool` | `false` | no |
| <a name="input_skip_remediation"></a> [skip\_remediation](#input\_skip\_remediation) | Skip creation of all remediation tasks for policies that DeployIfNotExists and Modify | `bool` | `true` | no |
| <a name="input_skip_role_assignment"></a> [skip\_role\_assignment](#input\_skip\_role\_assignment) | Should the module skip creation of role assignment for policies that DeployIfNotExists and Modify | `bool` | `false` | no |

## Outputs

No outputs.
