# Azure Policy Machine Configuration for Virtual Machines

[![cd-machine-config](https://github.com/gettek/terraform-azurerm-policy-as-code/actions/workflows/cd-guest-config.yml/badge.svg)](https://github.com/gettek/terraform-azurerm-policy-as-code/actions/workflows/cd-guest-config.yml)

This folder demonstrates an effective terraform workflow for continuous compliance with [Azure Policy Machine Configuration](https://learn.microsoft.com/en-us/azure/governance/machine-configuration/overview) (Uses PowerShell Desired State Config).

### Automating CGC Package Deployment

This example executes a terraform null resource to run the [build_machine_config_packages.ps1](../scripts/build_machine_config_packages.ps1) PowerShell script which builds and publishes Custom Machine Config (CGC) policy definitions, PS Module dependencies are installed with the `checkDependancies` flag.

On initial run or to rebuild/update existing configs, first target the null resource with parallelism set to 1 before running a complete apply such as below. This will prevent the [`GuestConfiguration`](https://www.powershellgallery.com/packages/GuestConfiguration/) PowerShell module from encountering conflicts during package creation. If the `checkDependancies` flag is unset each config should take approximately 10-15 seconds to publish packages and generate Definitions.

```bash
apply -target null_resource.build_machine_config_packages -parallelism=1 && tf apply
```

Definitions will stored in the local repo library under [Guest Configuration](../policies/Guest%20Configuration/)

> 💡 **Note:** see also [Terraform Provider: azurerm_policy_virtual_machine_configuration_assignment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/policy_virtual_machine_configuration_assignment)

### Links

- 📘 [Understand the machine configuration feature of Azure Automanage](https://learn.microsoft.com/en-us/azure/governance/machine-configuration/overview)
- 📘 [Azure Policy guest configuration extension](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/manage/azure-server-management/guest-configuration-policy)
- 📘 [How to set up a machine configuration authoring environment](https://learn.microsoft.com/en-us/azure/governance/machine-configuration/machine-configuration-create-setup)
- 📘 [How to create custom machine configuration package artifacts](https://learn.microsoft.com/en-us/azure/governance/machine-configuration/machine-configuration-create)
- 📘 [How to create custom machine configuration policy definitions](https://learn.microsoft.com/en-us/azure/governance/machine-configuration/machine-configuration-create-definition)
- 📘 [Remediation options for machine configuration](https://learn.microsoft.com/en-us/azure/governance/machine-configuration/machine-configuration-policy-effects)
- 📙 [DSC GitHub Community](https://github.com/dsccommunity)