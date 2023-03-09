# PowerShell Desired State Configs

[![cd-machine-config](https://github.com/gettek/terraform-azurerm-policy-as-code/actions/workflows/cd-guest-config.yml/badge.svg)](https://github.com/gettek/terraform-azurerm-policy-as-code/actions/workflows/cd-guest-config.yml)

This folder contains example desired state configs for both windows and linux machines, compiled by [build_machine_config_packages.ps1](../build_machine_config_packages.ps1). See the example deployment [ReadMe](../../examples-machine-config) for more information.

> 💡 **Note:** Linux configs are prefixed with `nx` so that the build script can determine which platform their respective policies belong in.
> 💡 **Note:** Versioning is suffixed to the filename so the build script can extract and include into policy definition metadata

## Links

- 📙 [Azure Policy Guest Configuration samples](https://github.com/Azure/azure-policy/tree/master/samples/GuestConfiguration/package-samples)
- 📙 [DSC GitHub Community](https://github.com/dsccommunity)