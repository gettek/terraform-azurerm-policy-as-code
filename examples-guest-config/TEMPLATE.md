# Azure Policy Guest Configuration for Virtual Machines

This folder demonstrates an effective terraform workflow for continuous compliance with [Azure Policy Guest Configuration](https://learn.microsoft.com/en-us/azure/governance/policy/concepts/guest-configuration) (PowerShell Desired State Config).

### [How to create custom guest configuration package artifacts](https://learn.microsoft.com/en-us/azure/governance/policy/how-to/guest-configuration-create)

### Automating CGC Package Deployment

This example executes a terraform null resource to run the [build_guest_config_packages.ps1](../scripts/build_guest_config_packages.ps1) PowerShell script which builds and publishes Custom Guest Config (CGC) policy definitions, local PowerShell module dependencies are installed with the `checkDependancies` flag, requires `pwsh7`.

CGC Definitions will be added to the local library under the **"Guest Configuration"** category prefixed with **"CGC_"** for terraform to identify with the `fileset()` function in our [included example](initiatives.tf#L41).

> 💡 **Note:** see also [Terraform Provider: azurerm_policy_virtual_machine_configuration_assignment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/policy_virtual_machine_configuration_assignment)
