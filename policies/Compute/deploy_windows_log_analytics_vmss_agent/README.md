# Windows Log Analytics VMSS Agent Extension

## Display Name

Deploy Log Analytics Agent Extension for Windows VMSS

## Mode

`Indexed`

## Description

Deploy Log Analytics agent for Windows virtual machine scale sets if the VM Image (OS) is in the list defined and the agent is not installed. The list of OS images will be updated over time as support is updated. Note: if your scale set upgradePolicy is set to Manual, you need to apply the extension to the all VMs in the set by calling upgrade on them. In CLI this would be az vmss update-instances.

## References

[Built-In: Deploy Log Analytics agent for Windows virtual machine scale sets](https://github.com/Azure/azure-policy/blob/master/built-in-policies/policyDefinitions/Monitoring/LogAnalyticsExtension_Windows_VMSS_Deploy.json)

[Built-In: Deploy Dependency agent for Windows virtual machine scale sets](https://github.com/Azure/azure-policy/blob/master/built-in-policies/policyDefinitions/Monitoring/DependencyAgentExtension_Windows_VMSS_Deploy.json)
