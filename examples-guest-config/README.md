# Azure Policy Guest Configuration for Virtual Machines

This folder demonstrates an effective terraform workflow for continuous compliance with [Azure Policy Guest Configuration](https://learn.microsoft.com/en-us/azure/governance/policy/concepts/guest-configuration) (PowerShell Desired State Config).

### [How to create custom guest configuration package artifacts](https://learn.microsoft.com/en-us/azure/governance/policy/how-to/guest-configuration-create)

### Automating CGC Package Deployment

This example executes a terraform null resource to run the [build_guest_config_packages.ps1](../scripts/build_guest_config_packages.ps1) PowerShell script which builds and publishes Custom Guest Config (CGC) policy definitions, local PowerShell module dependencies are installed with the `checkDependancies` flag, requires `pwsh7`.

CGC Definitions will be added to the local library under the **"Guest Configuration"** category prefixed with **"CGC_"** for terraform to identify with the `fileset()` function in our [included example](initiatives.tf#L41).

> 💡 **Note:** see also [Terraform Provider: azurerm_policy_virtual_machine_configuration_assignment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/policy_virtual_machine_configuration_assignment)


## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |
| <a name="provider_local"></a> [local](#provider\_local) | n/a |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_guest_config_prereqs"></a> [guest\_config\_prereqs](#module\_guest\_config\_prereqs) | ..//modules/definition | n/a |
| <a name="module_guest_config_prereqs_initiative"></a> [guest\_config\_prereqs\_initiative](#module\_guest\_config\_prereqs\_initiative) | ..//modules/initiative | n/a |
| <a name="module_team_a_mg_guest_config_prereqs_initiative"></a> [team\_a\_mg\_guest\_config\_prereqs\_initiative](#module\_team\_a\_mg\_guest\_config\_prereqs\_initiative) | ..//modules/set_assignment | n/a |
| <a name="module_team_a_mg_vm_custom_guest_configs"></a> [team\_a\_mg\_vm\_custom\_guest\_configs](#module\_team\_a\_mg\_vm\_custom\_guest\_configs) | ..//modules/def_assignment | n/a |

## Resources

| Name | Type |
|------|------|
| [null_resource.guest_config_packages_script](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_management_group.org](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/management_group) | data source |
| [azurerm_management_group.team_a](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/management_group) | data source |
| [azurerm_policy_definition.custom_guest_config_definitions](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/policy_definition) | data source |
| [azurerm_role_definition.contributor](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/role_definition) | data source |
| [azurerm_storage_container.guest_config_container](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_container) | data source |
| [local_file.cgc_definition_list](https://registry.terraform.io/providers/hashicorp/local/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_build_packages"></a> [build\_packages](#input\_build\_packages) | Create and publish custom guest config polices with build\_guest\_config\_packages.ps1 | `bool` | `true` | no |
| <a name="input_skip_remediation"></a> [skip\_remediation](#input\_skip\_remediation) | Skip creation of all remediation tasks for policies that DeployIfNotExists and Modify | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cgc_definition_list"></a> [cgc\_definition\_list](#output\_cgc\_definition\_list) | output of the build packages script |
