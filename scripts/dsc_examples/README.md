# PowerShell Desired State Configs

[![cd-machine-config](https://github.com/gettek/terraform-azurerm-policy-as-code/actions/workflows/cd-guest-config.yml/badge.svg)](https://github.com/gettek/terraform-azurerm-policy-as-code/actions/workflows/cd-guest-config.yml)

This folder contains some example desired state configs for both windows and linux machines, compiled by [build_machine_config_packages.ps1](../build_machine_config_packages.ps1)

> 💡 **Note:** Linux configs are prefixed with `nx` so that the build script can determine which platform their respective policies belong in.
> 💡 **Note:** Versioning is suffixed to the filename so the build script can extract and include into policy definition metadata

## Links

- 📘 [Understand the machine configuration feature of Azure Automanage](https://learn.microsoft.com/en-us/azure/governance/machine-configuration/overview)
- 📘 [Azure Policy guest configuration extension](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/manage/azure-server-management/guest-configuration-policy)
- 📘 [Remediation options for machine configuration](https://learn.microsoft.com/en-us/azure/governance/machine-configuration/machine-configuration-policy-effects)
- 📘 [How to create custom machine configuration package artifacts](https://learn.microsoft.com/en-us/azure/governance/machine-configuration/machine-configuration-create)
- 📙 [DSC GitHub Community](https://github.com/dsccommunity)