# Azure Policy Guest Configuration for Virtual Machines

This folder demonstrates an effective terraform workflow for continuous compliance with [Azure Policy Guest Configuration](https://docs.microsoft.com/en-us/azure/governance/policy/concepts/guest-configuration) (PowerShell Desired State Config).

### [How to create custom guest configuration package artifacts](https://docs.microsoft.com/en-us/azure/governance/policy/how-to/guest-configuration-create)

### Automating CGC Package Deployment

This example executes a terraform null resource to run the [build_guest_config_packages.ps1](../scripts/build_guest_config_packages.ps1) PowerShell script which builds and publishes Custom Guest Config (CGC) policy definitions, local PowerShell module dependencies are installed with the `checkDependancies` flag, requires `pwsh7`.

CGC Definitions will be added to the local library under the **"Guest Configuration"** category prefixed with **"CGC_"** for terraform to identify with the `fileset()` function in our [included example](initiatives.tf#L41).


## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 2.84.0 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.1.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_custom_guest_configs"></a> [custom\_guest\_configs](#module\_custom\_guest\_configs) | ..//modules/definition | n/a |
| <a name="module_custom_guest_configs_initiative"></a> [custom\_guest\_configs\_initiative](#module\_custom\_guest\_configs\_initiative) | ..//modules/initiative | n/a |
| <a name="module_guest_config_prereqs"></a> [guest\_config\_prereqs](#module\_guest\_config\_prereqs) | ..//modules/definition | n/a |
| <a name="module_guest_config_prereqs_initiative"></a> [guest\_config\_prereqs\_initiative](#module\_guest\_config\_prereqs\_initiative) | ..//modules/initiative | n/a |
| <a name="module_team_a_mg_custom_guest_configs_initiative"></a> [team\_a\_mg\_custom\_guest\_configs\_initiative](#module\_team\_a\_mg\_custom\_guest\_configs\_initiative) | ..//modules/set_assignment | n/a |
| <a name="module_team_a_mg_guest_config_prereqs_initiative"></a> [team\_a\_mg\_guest\_config\_prereqs\_initiative](#module\_team\_a\_mg\_guest\_config\_prereqs\_initiative) | ..//modules/set_assignment | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.guest_config_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_storage_account.guest_config_store](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_container.guest_config_container](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [null_resource.guest_config_packages_script](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_management_group.org](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/management_group) | data source |
| [azurerm_management_group.team_a](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/management_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_build_packages"></a> [build\_packages](#input\_build\_packages) | Create and publish custom guest config polices with build\_guest\_config\_packages.ps1 | `bool` | `true` | no |
| <a name="input_skip_remediation"></a> [skip\_remediation](#input\_skip\_remediation) | Skip creation of all remediation tasks for policies that DeployIfNotExists and Modify | `bool` | `false` | no |

## Outputs

No outputs.
