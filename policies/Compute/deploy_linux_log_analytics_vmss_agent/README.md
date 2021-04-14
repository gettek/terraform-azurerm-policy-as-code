# Linux Log Analytics VMSS Agent Extension

## Display Name

Deploy Linux Log Analytics Agent VM Extension

## Mode

`Indexed`

## LA Agent

Deploy Log Analytics and Dependency agents for Linux virtual machine scale sets if the VM Image (OS) is in the list defined and the agent is not installed. Note: if your scale set upgradePolicy is set to Manual, you need to apply the extension to the all VMs in the set by calling upgrade on them. In CLI this would be az vmss update-instances.

## References

[Built-In: Deploy Log Analytics agent for Linux virtual machine scale sets](https://github.com/Azure/azure-policy/blob/master/built-in-policies/policyDefinitions/Monitoring/LogAnalyticsExtension_Linux_VMSS_Deploy.json)

[Built-In: Deploy Dependency agent for Linux virtual machine scale sets](https://github.com/Azure/azure-policy/blob/master/built-in-policies/policyDefinitions/Monitoring/DependencyAgentExtension_Linux_VM_Deploy.json)

