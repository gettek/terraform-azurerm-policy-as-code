
# Local Policy Definitions
Compile time: 12/20/2021 17:21:01 UTC

## Categories
- [Automation](#Automation)
- [Compute](#Compute)
- [General](#General)
- [Guest Configuration](#Guest-Configuration)
- [Monitoring](#Monitoring)
- [Network](#Network)
- [Security Center](#Security-Center)
- [Storage](#Storage)
- [Tags](#Tags)

# Definitions

## Automation

### onboard_to_automation_dsc_linux
| Title | Description |
| ----- | ----------- |
| Name                | onboard_to_automation_dsc_linux |
| DisplayName         | Onboard Azure VM and Arc connected Linux machines to Azure Automation DSC |
| Description         | Deploys the DSC extension to onboard Linux nodes to Azure Automation DSC. Assigns a configuration. |
| Effect              | [parameters('effect')] |

#### ~ Parameters (onboard_to_automation_dsc_linux)
| Name | Description | Default Value |
| ---- | ----------- | ------------- |
| effect | Enable or disable the execution of the policy | DeployIfNotExists |
| automationAccountId | Automation Account Id. If this account is outside of the scope of the assignment you must manually grant 'Contributor' permissions (or similar) on the Automation account to the policy assignment's principal ID. |  |
| nxNodeConfigurationName | Specifies the node configuration in the Automation account to assign to the node. NOTE: will auto-suffix '.localhost'. |  |
| nodeConfigurationMode | Specifies the mode for LCM. Valid options include ApplyOnly, ApplyandMonitor, and ApplyandAutoCorrect. The default value is ApplyAndAutoCorrect. | ApplyAndAutoCorrect |
| listOfImageIdToInclude_linux | Example value: '/subscriptions/<subscriptionId>/resourceGroups/YourResourceGroup/providers/Microsoft.Compute/images/ContosoStdImage' |  |

<br>

<br>

### onboard_to_automation_dsc_windows
| Title | Description |
| ----- | ----------- |
| Name                | onboard_to_automation_dsc_windows |
| DisplayName         | Onboard Azure VM and Arc connected Windows machines to Azure Automation DSC |
| Description         | Deploys the DSC extension to onboard Windows nodes to Azure Automation DSC. Assigns a configuration. |
| Effect              | [parameters('effect')] |

#### ~ Parameters (onboard_to_automation_dsc_windows)
| Name | Description | Default Value |
| ---- | ----------- | ------------- |
| effect | Enable or disable the execution of the policy | DeployIfNotExists |
| automationAccountId | Automation Account Id. If this account is outside of the scope of the assignment you must manually grant 'Contributor' permissions (or similar) on the Automation account to the policy assignment's principal ID. |  |
| nodeConfigurationName | Specifies the node configuration in the Automation account to assign to the node. NOTE: will auto-suffix '.localhost'. |  |
| nodeConfigurationMode | Specifies the mode for LCM. Valid options include ApplyOnly, ApplyandMonitor, and ApplyandAutoCorrect. The default value is ApplyAndAutoCorrect. | ApplyAndAutoCorrect |
| listOfImageIdToInclude_windows | Example value: '/subscriptions/<subscriptionId>/resourceGroups/YourResourceGroup/providers/Microsoft.Compute/images/ContosoStdImage' |  |

<br>

<br>

---

## Compute

### deploy_linux_lad_vm_agent
| Title | Description |
| ----- | ----------- |
| Name                | deploy_linux_lad_vm_agent |
| DisplayName         |  |
| Description         |  |
| Effect              | [parameters('effect')] |

#### ~ Parameters (deploy_linux_lad_vm_agent)
| Name | Description | Default Value |
| ---- | ----------- | ------------- |
| effect | Enable or disable the execution of the policy | DeployIfNotExists |
| diagnosticsStorageAccountName | The Storage Account Id to send diagnostic logs |  |
| diagnosticsStorageAccountSas | The Storage Account SAS Token to send diagnostic logs |  |
| listOfImageIdToInclude_linux | Example value: '/subscriptions/<subscriptionId>/resourceGroups/YourResourceGroup/providers/Microsoft.Compute/images/ContosoStdImage' |  |

<br>

<br>

### deploy_linux_lad_vmss_agent
| Title | Description |
| ----- | ----------- |
| Name                | deploy_linux_lad_vmss_agent |
| DisplayName         |  |
| Description         |  |
| Effect              | [parameters('effect')] |

#### ~ Parameters (deploy_linux_lad_vmss_agent)
| Name | Description | Default Value |
| ---- | ----------- | ------------- |
| effect | Enable or disable the execution of the policy | DeployIfNotExists |
| diagnosticsStorageAccountName | The Storage Account Id to send diagnostic logs |  |
| diagnosticsStorageAccountSas | The Storage Account SAS Token to send diagnostic logs |  |
| eventHubUrl | The EventHub Url to stream diagnostic logs to. e.g. https://myeventhub-ns.servicebus.windows.net/diageventhub |  |
| eventHubSASToken | The Event Hub Shared Access Token |  |
| listOfImageIdToInclude_linux | Example value: '/subscriptions/<subscriptionId>/resourceGroups/YourResourceGroup/providers/Microsoft.Compute/images/ContosoStdImage' |  |

<br>

<br>

### deploy_linux_log_analytics_vm_agent
| Title | Description |
| ----- | ----------- |
| Name                | deploy_linux_log_analytics_vm_agent |
| DisplayName         |  |
| Description         |  |
| Effect              | [parameters('effect')] |

#### ~ Parameters (deploy_linux_log_analytics_vm_agent)
| Name | Description | Default Value |
| ---- | ----------- | ------------- |
| effect | Enable or disable the execution of the policy | DeployIfNotExists |
| workspaceId | Specify the Log Analytics Workspace Id the agent should be connected to. If this workspace is outside of the scope of the assignment you must manually grant 'Log Analytics Contributor' permissions (or similar) to the policy assignment's principal ID. |  |
| listOfImageIdToInclude_linux | Example value: '/subscriptions/<subscriptionId>/resourceGroups/YourResourceGroup/providers/Microsoft.Compute/images/ContosoStdImage' |  |

<br>

<br>

### deploy_linux_log_analytics_vmss_agent
| Title | Description |
| ----- | ----------- |
| Name                | deploy_linux_log_analytics_vmss_agent |
| DisplayName         |  |
| Description         |  |
| Effect              | [parameters('effect')] |

#### ~ Parameters (deploy_linux_log_analytics_vmss_agent)
| Name | Description | Default Value |
| ---- | ----------- | ------------- |
| effect | Enable or disable the execution of the policy | DeployIfNotExists |
| workspaceId | Specify the Log Analytics Workspace Id the agent should be connected to. If this workspace is outside of the scope of the assignment you must manually grant 'Log Analytics Contributor' permissions (or similar) to the policy assignment's principal ID. |  |
| listOfImageIdToInclude_linux | Example value: '/subscriptions/<subscriptionId>/resourceGroups/YourResourceGroup/providers/Microsoft.Compute/images/ContosoStdImage' |  |

<br>

<br>

### deploy_windows_log_analytics_vm_agent
| Title | Description |
| ----- | ----------- |
| Name                | deploy_windows_log_analytics_vm_agent |
| DisplayName         |  |
| Description         |  |
| Effect              | [parameters('effect')] |

#### ~ Parameters (deploy_windows_log_analytics_vm_agent)
| Name | Description | Default Value |
| ---- | ----------- | ------------- |
| effect | Enable or disable the execution of the policy | DeployIfNotExists |
| workspaceId | Specify the Log Analytics Workspace Id the agent should be connected to. If this workspace is outside of the scope of the assignment you must manually grant 'Log Analytics Contributor' permissions (or similar) to the policy assignment's principal ID. |  |
| listOfImageIdToInclude_windows | Example value: '/subscriptions/<subscriptionId>/resourceGroups/YourResourceGroup/providers/Microsoft.Compute/images/ContosoStdImage' |  |

<br>

<br>

### deploy_windows_log_analytics_vmss_agent
| Title | Description |
| ----- | ----------- |
| Name                | deploy_windows_log_analytics_vmss_agent |
| DisplayName         |  |
| Description         |  |
| Effect              | [parameters('effect')] |

#### ~ Parameters (deploy_windows_log_analytics_vmss_agent)
| Name | Description | Default Value |
| ---- | ----------- | ------------- |
| effect | Enable or disable the execution of the policy | DeployIfNotExists |
| workspaceId | Specify the Log Analytics Workspace Id the agent should be connected to. If this workspace is outside of the scope of the assignment you must manually grant 'Log Analytics Contributor' permissions (or similar) to the policy assignment's principal ID. |  |
| listOfImageIdToInclude_windows | Example value: '/subscriptions/<subscriptionId>/resourceGroups/YourResourceGroup/providers/Microsoft.Compute/images/ContosoStdImage' |  |

<br>

<br>

### deploy_windows_wad_vm_agent
| Title | Description |
| ----- | ----------- |
| Name                | deploy_windows_wad_vm_agent |
| DisplayName         |  |
| Description         |  |
| Effect              | [parameters('effect')] |

#### ~ Parameters (deploy_windows_wad_vm_agent)
| Name | Description | Default Value |
| ---- | ----------- | ------------- |
| effect | Enable or disable the execution of the policy | DeployIfNotExists |
| diagnosticsStorageAccountName | The Storage Account Id to send diagnostic logs |  |
| diagnosticsStorageAccountId | The Storage Account Id to send diagnostic logs |  |
| eventHubSharedAccessKeyId | The Event Hub Shared Access Key Key Resource Id. |  |
| eventHubSharedAccessKeyName | The Event Hub Shared Access Key Name. Defaults to the Root Key | RootManageSharedAccessKey |
| eventHubUrl | The EventHub Url to stream diagnostic logs to. e.g. https://myeventhub-ns.servicebus.windows.net/diageventhub |  |
| listOfImageIdToInclude_windows | Example value: '/subscriptions/<subscriptionId>/resourceGroups/YourResourceGroup/providers/Microsoft.Compute/images/ContosoStdImage' |  |

<br>

<br>

### deploy_windows_wad_vmss_agent
| Title | Description |
| ----- | ----------- |
| Name                | deploy_windows_wad_vmss_agent |
| DisplayName         |  |
| Description         |  |
| Effect              | [parameters('effect')] |

#### ~ Parameters (deploy_windows_wad_vmss_agent)
| Name | Description | Default Value |
| ---- | ----------- | ------------- |
| effect | Enable or disable the execution of the policy | DeployIfNotExists |
| diagnosticsStorageAccountName | The Storage Account Id to send diagnostic logs |  |
| diagnosticsStorageAccountId | The Storage Account Id to send diagnostic logs |  |
| eventHubSharedAccessKeyId | The Event Hub Shared Access Key Key Resource Id. |  |
| eventHubSharedAccessKeyName | The Event Hub Shared Access Key Name. Defaults to the Root Key | RootManageSharedAccessKey |
| eventHubUrl | The EventHub Url to stream diagnostic logs to. e.g. https://myeventhub-ns.servicebus.windows.net/diageventhub |  |
| listOfImageIdToInclude_windows | Example value: '/subscriptions/<subscriptionId>/resourceGroups/YourResourceGroup/providers/Microsoft.Compute/images/ContosoStdImage' |  |

<br>

<br>

### preview_deploy_linux_azure_monitor_vm_agent
| Title | Description |
| ----- | ----------- |
| Name                | preview_deploy_linux_azure_monitor_vm_agent |
| DisplayName         |  |
| Description         |  |
| Effect              | deployIfNotExists |

#### ~ Parameters (preview_deploy_linux_azure_monitor_vm_agent)
| Name | Description | Default Value |
| ---- | ----------- | ------------- |
| effect | Enable or disable the execution of the policy | DeployIfNotExists |
| listOfImageIdToInclude_linux | Example value: '/subscriptions/<subscriptionId>/resourceGroups/YourResourceGroup/providers/Microsoft.Compute/images/ContosoStdImage' |  |

<br>

<br>

### preview_deploy_windows_azure_monitor_vm_agent
| Title | Description |
| ----- | ----------- |
| Name                | preview_deploy_windows_azure_monitor_vm_agent |
| DisplayName         |  |
| Description         |  |
| Effect              | [parameters('effect')] |

#### ~ Parameters (preview_deploy_windows_azure_monitor_vm_agent)
| Name | Description | Default Value |
| ---- | ----------- | ------------- |
| effect | Enable or disable the execution of the policy | DeployIfNotExists |
| listOfImageIdToInclude_windows | Example value: '/subscriptions/<subscriptionId>/resourceGroups/YourResourceGroup/providers/Microsoft.Compute/images/ContosoStdImage' |  |

<br>

<br>

---

## General

### deny_resources_types
| Title | Description |
| ----- | ----------- |
| Name                | deny_resources_types |
| DisplayName         |  |
| Description         |  |
| Effect              | [parameters('effect')] |

#### ~ Parameters (deny_resources_types)
| Name | Description | Default Value |
| ---- | ----------- | ------------- |
| listOfResourceTypesNotAllowed | The list of resource types that cannot be deployed. |  |
| effect | The effect determines what happens when the policy rule is evaluated to match | Audit |

<br>

<br>

### whitelist_regions
| Title | Description |
| ----- | ----------- |
| Name                | whitelist_regions |
| DisplayName         |  |
| Description         |  |
| Effect              | [parameters('effect')] |

#### ~ Parameters (whitelist_regions)
| Name | Description | Default Value |
| ---- | ----------- | ------------- |
| listOfRegionsAllowed | The list of regions where resources can be deployed. | UK South UK West |
| effect | The effect determines what happens when the policy rule is evaluated to match | Audit |

<br>

<br>

### whitelist_resources
| Title | Description |
| ----- | ----------- |
| Name                | whitelist_resources |
| DisplayName         |  |
| Description         |  |
| Effect              | [parameters('effect')] |

#### ~ Parameters (whitelist_resources)
| Name | Description | Default Value |
| ---- | ----------- | ------------- |
| listOfResourceTypesAllowed | The list of resource types that can be deployed. |  |
| effect | The effect determines what happens when the policy rule is evaluated to match | Audit |

<br>

<br>

---

## Guest Configuration

### add_system_identity_when_user_prerequisite
| Title | Description |
| ----- | ----------- |
| Name                | Add_System_Identity_When_User |
| DisplayName         | Add system-assigned managed identity when User-Assigned is present to enable Guest Configuration assignments on VMs |
| Description         | This policy adds a system-assigned managed identity to virtual machines hosted in Azure that are supported by Guest Configuration and have at least one user-assigned identity but do not have a system-assigned managed identity. A system-assigned managed identity is a prerequisite for all Guest Configuration assignments and must be added to machines before using any Guest Configuration policy definitions. For more information on Guest Configuration, visit https://aka.ms/gcpol. |
| Effect              | modify |

#### ~ Parameters (add_system_identity_when_user_prerequisite)
| Name | Description | Default Value |
| ---- | ----------- | ------------- |
| listOfImageIdToInclude_windows | Example value: '/subscriptions/<subscriptionId>/resourceGroups/YourResourceGroup/providers/Microsoft.Compute/images/ContosoStdImage' |  |
| listOfImageIdToInclude_linux | Example value: '/subscriptions/<subscriptionId>/resourceGroups/YourResourceGroup/providers/Microsoft.Compute/images/ContosoStdImage' |  |

<br>

<br>

### CGC_nxLAMPServer
| Title | Description |
| ----- | ----------- |
| Name                | CGC_nxLAMPServer |
| DisplayName         | nxLAMPServer |
| Description         | VM Custom Guest Configuration: nxLAMPServer |
| Effect              | deployIfNotExists |

#### ~ Parameters (CGC_nxLAMPServer)
| Name | Description | Default Value |
| ---- | ----------- | ------------- |
| IncludeArcMachines | By selecting this option, you agree to be charged monthly per Arc connected machine. | False |

<br>

<br>

### CGC_SecurityBaselineConfigurationWS2016
| Title | Description |
| ----- | ----------- |
| Name                | CGC_SecurityBaselineConfigurationWS2016 |
| DisplayName         | SecurityBaselineConfigurationWS2016 |
| Description         | VM Custom Guest Configuration: SecurityBaselineConfigurationWS2016 |
| Effect              | deployIfNotExists |

#### ~ Parameters (CGC_SecurityBaselineConfigurationWS2016)
| Name | Description | Default Value |
| ---- | ----------- | ------------- |
| IncludeArcMachines | By selecting this option, you agree to be charged monthly per Arc connected machine. | False |

<br>

<br>

### CGC_WindowsIISServerConfig
| Title | Description |
| ----- | ----------- |
| Name                | CGC_WindowsIISServerConfig |
| DisplayName         | WindowsIISServerConfig |
| Description         | VM Custom Guest Configuration: WindowsIISServerConfig |
| Effect              | deployIfNotExists |

#### ~ Parameters (CGC_WindowsIISServerConfig)
| Name | Description | Default Value |
| ---- | ----------- | ------------- |
| IncludeArcMachines | By selecting this option, you agree to be charged monthly per Arc connected machine. | False |

<br>

<br>

### deploy_extension_linux_prerequisite
| Title | Description |
| ----- | ----------- |
| Name                | Deploy_the_Linux_Guest_Configuration_extension |
| DisplayName         | Deploy the Linux Guest Configuration extension to enable Guest Configuration assignments on Linux VMs |
| Description         | This policy deploys the Linux Guest Configuration extension to Linux virtual machines hosted in Azure that are supported by Guest Configuration. The Linux Guest Configuration extension is a prerequisite for all Linux Guest Configuration assignments and must be deployed to machines before using any Linux Guest Configuration policy definition. For more information on Guest Configuration, visit https://aka.ms/gcpol. |
| Effect              | deployIfNotExists |

#### ~ Parameters (deploy_extension_linux_prerequisite)
| Name | Description | Default Value |
| ---- | ----------- | ------------- |
| listOfImageIdToInclude_linux | Example value: '/subscriptions/<subscriptionId>/resourceGroups/YourResourceGroup/providers/Microsoft.Compute/images/ContosoStdImage' |  |

<br>

<br>

### deploy_extension_windows_prerequisite
| Title | Description |
| ----- | ----------- |
| Name                | Deploy_the_Windows_Guest_Configuration_extension |
| DisplayName         | Deploy the Windows Guest Configuration extension to enable Guest Configuration assignments on Windows VMs |
| Description         | This policy deploys the Windows Guest Configuration extension to Windows virtual machines hosted in Azure that are supported by Guest Configuration. The Windows Guest Configuration extension is a prerequisite for all Windows Guest Configuration assignments and must be deployed to machines before using any Windows Guest Configuration policy definition. For more information on Guest Configuration, visit https://aka.ms/gcpol. |
| Effect              | deployIfNotExists |

#### ~ Parameters (deploy_extension_windows_prerequisite)
| Name | Description | Default Value |
| ---- | ----------- | ------------- |
| listOfImageIdToInclude_windows | Example value: '/subscriptions/<subscriptionId>/resourceGroups/YourResourceGroup/providers/Microsoft.Compute/images/ContosoStdImage' |  |

<br>

<br>

### add_system_identity_when_none_prerequisite
| Title | Description |
| ----- | ----------- |
| Name                | Add_System_Identity_When_None |
| DisplayName         | Add system-assigned managed identity when none present to enable Guest Configuration assignments on virtual machines |
| Description         | This policy adds a system-assigned managed identity to virtual machines hosted in Azure that are supported by Guest Configuration but do not have any managed identities. A system-assigned managed identity is a prerequisite for all Guest Configuration assignments and must be added to machines before using any Guest Configuration policy definitions. For more information on Guest Configuration, visit https://aka.ms/gcpol. |
| Effect              | modify |

#### ~ Parameters (add_system_identity_when_none_prerequisite)
| Name | Description | Default Value |
| ---- | ----------- | ------------- |
| listOfImageIdToInclude_windows | Example value: '/subscriptions/<subscriptionId>/resourceGroups/YourResourceGroup/providers/Microsoft.Compute/images/ContosoStdImage' |  |
| listOfImageIdToInclude_linux | Example value: '/subscriptions/<subscriptionId>/resourceGroups/YourResourceGroup/providers/Microsoft.Compute/images/ContosoStdImage' |  |

<br>

<br>

---

## Monitoring

### deploy_public_ip_diagnostic_setting
| Title | Description |
| ----- | ----------- |
| Name                | deploy_public_ip_diagnostic_setting |
| DisplayName         |  |
| Description         |  |
| Effect              | [parameters('effect')] |

#### ~ Parameters (deploy_public_ip_diagnostic_setting)
| Name | Description | Default Value |
| ---- | ----------- | ------------- |
| effect | Enable or disable the execution of the policy | DeployIfNotExists |
| profileName | The diagnostic settings profile name | setbypolicy_Diagnostics |
| workspaceId | Select Log Analytics workspace from dropdown list. If this workspace is outside of the scope of the assignment you must manually grant 'Log Analytics Contributor' permissions (or similar) to the policy assignment's principal ID. |  |
| storageAccountId | The Storage Account Resource Id to send activity logs |  |
| eventHubAuthorizationRuleId | The Event Hub authorization rule Id for Azure Diagnostics. The authorization rule needs to be at Event Hub namespace level. e.g. /subscriptions/{subscription Id}/resourceGroups/{resource group}/providers/Microsoft.EventHub/namespaces/{Event Hub namespace}/authorizationrules/{authorization rule} |  |
| eventHubName | The EventHub name to stream activity logs to |  |
| metricsEnabled | Enable Metrics - True or False | True |
| logsEnabled | Enable Logs - True or False | True |

<br>

<br>

### deploy_storage_account_diagnostic_setting
| Title | Description |
| ----- | ----------- |
| Name                | deploy_storage_account_diagnostic_setting |
| DisplayName         | Deploy Diagnostic Settings for Azure Storage, including blobs, files, tables, and queues to a Log Analytics workspace |
| Description         | Deploys the diagnostic settings for Azure Storage, including blobs, files, tables, and queues to stream to a regional Log Analytics workspace when any Azure Storage which is missing this diagnostic settings is created or updated. |
| Effect              | [parameters('effect')] |

#### ~ Parameters (deploy_storage_account_diagnostic_setting)
| Name | Description | Default Value |
| ---- | ----------- | ------------- |
| effect | Enable or disable the execution of the policy | DeployIfNotExists |
| profileName | The diagnostic settings profile name | setbypolicy_Diagnostics |
| workspaceId | Select Log Analytics workspace from dropdown list. If this workspace is outside of the scope of the assignment you must manually grant 'Log Analytics Contributor' permissions (or similar) to the policy assignment's principal ID. |  |
| storageAccountId | The Storage Account Resource Id to send activity logs |  |
| eventHubAuthorizationRuleId | The Event Hub authorization rule Id for Azure Diagnostics. The authorization rule needs to be at Event Hub namespace level. e.g. /subscriptions/{subscription Id}/resourceGroups/{resource group}/providers/Microsoft.EventHub/namespaces/{Event Hub namespace}/authorizationrules/{authorization rule} |  |
| eventHubName | The EventHub name to stream activity logs to |  |
| metricsEnabled | Whether to enable metrics stream to the Log Analytics workspace - True or False | False |
| logsEnabled | Enable Logs - True or False | True |

<br>

<br>

### deploy_subscription_diagnostic_setting
| Title | Description |
| ----- | ----------- |
| Name                | deploy_subscription_diagnostic_setting |
| DisplayName         |  |
| Description         |  |
| Effect              | [parameters('effect')] |

#### ~ Parameters (deploy_subscription_diagnostic_setting)
| Name | Description | Default Value |
| ---- | ----------- | ------------- |
| effect | Enable or disable the execution of the policy | DeployIfNotExists |
| profileName | The diagnostic settings profile name | setbypolicy_Diagnostics |
| workspaceId | Select Log Analytics workspace from dropdown list. If this workspace is outside of the scope of the assignment you must manually grant 'Log Analytics Contributor' permissions (or similar) to the policy assignment's principal ID. |  |
| storageAccountId | The Storage Account Resource Id to send activity logs |  |
| eventHubAuthorizationRuleId | The Event Hub authorization rule Id for Azure Diagnostics. The authorization rule needs to be at Event Hub namespace level. e.g. /subscriptions/{subscription Id}/resourceGroups/{resource group}/providers/Microsoft.EventHub/namespaces/{Event Hub namespace}/authorizationrules/{authorization rule} |  |
| eventHubName | The EventHub name to stream activity logs to |  |
| logsEnabled | Enable Logs - True or False | True |

<br>

<br>

### deploy_virtual_machine_diagnostic_setting
| Title | Description |
| ----- | ----------- |
| Name                | deploy_virtual_machine_diagnostic_setting |
| DisplayName         |  |
| Description         |  |
| Effect              | [parameters('effect')] |

#### ~ Parameters (deploy_virtual_machine_diagnostic_setting)
| Name | Description | Default Value |
| ---- | ----------- | ------------- |
| effect | Enable or disable the execution of the policy | DeployIfNotExists |
| profileName | The diagnostic settings profile name | setbypolicy_Diagnostics |
| workspaceId | Select Log Analytics workspace from dropdown list. If this workspace is outside of the scope of the assignment you must manually grant 'Log Analytics Contributor' permissions (or similar) to the policy assignment's principal ID. |  |
| storageAccountId | The Storage Account Resource Id to send activity logs |  |
| eventHubAuthorizationRuleId | The Event Hub authorization rule Id for Azure Diagnostics. The authorization rule needs to be at Event Hub namespace level. e.g. /subscriptions/{subscription Id}/resourceGroups/{resource group}/providers/Microsoft.EventHub/namespaces/{Event Hub namespace}/authorizationrules/{authorization rule} |  |
| eventHubName | The EventHub name to stream activity logs to |  |
| metricsEnabled | Whether to enable metrics stream to the Log Analytics workspace - True or False | False |
| logsEnabled | Whether to enable logs stream to the Log Analytics workspace - True or False | True |

<br>

<br>

### deploy_vnet_diagnostic_setting
| Title | Description |
| ----- | ----------- |
| Name                | deploy_vnet_diagnostic_setting |
| DisplayName         |  |
| Description         |  |
| Effect              | [parameters('effect')] |

#### ~ Parameters (deploy_vnet_diagnostic_setting)
| Name | Description | Default Value |
| ---- | ----------- | ------------- |
| effect | Enable or disable the execution of the policy | DeployIfNotExists |
| profileName | The diagnostic settings profile name | setbypolicy_Diagnostics |
| workspaceId | Select Log Analytics workspace from dropdown list. If this workspace is outside of the scope of the assignment you must manually grant 'Log Analytics Contributor' permissions (or similar) to the policy assignment's principal ID. |  |
| storageAccountId | The Storage Account Resource Id to send activity logs |  |
| eventHubAuthorizationRuleId | The Event Hub authorization rule Id for Azure Diagnostics. The authorization rule needs to be at Event Hub namespace level. e.g. /subscriptions/{subscription Id}/resourceGroups/{resource group}/providers/Microsoft.EventHub/namespaces/{Event Hub namespace}/authorizationrules/{authorization rule} |  |
| eventHubName | The EventHub name to stream activity logs to |  |
| metricsEnabled | Whether to enable metrics stream to the Log Analytics workspace - True or False | False |
| logsEnabled | Whether to enable logs stream to the Log Analytics workspace - True or False | True |

<br>

<br>

### deploy_vnet_gateway_diagnostic_setting
| Title | Description |
| ----- | ----------- |
| Name                | deploy_vnet_gateway_diagnostic_setting |
| DisplayName         |  |
| Description         |  |
| Effect              | [parameters('effect')] |

#### ~ Parameters (deploy_vnet_gateway_diagnostic_setting)
| Name | Description | Default Value |
| ---- | ----------- | ------------- |
| effect | Enable or disable the execution of the policy | DeployIfNotExists |
| profileName | The diagnostic settings profile name | setbypolicy_Diagnostics |
| workspaceId | Select Log Analytics workspace from dropdown list. If this workspace is outside of the scope of the assignment you must manually grant 'Log Analytics Contributor' permissions (or similar) to the policy assignment's principal ID. |  |
| storageAccountId | The Storage Account Resource Id to send activity logs |  |
| eventHubAuthorizationRuleId | The Event Hub authorization rule Id for Azure Diagnostics. The authorization rule needs to be at Event Hub namespace level. e.g. /subscriptions/{subscription Id}/resourceGroups/{resource group}/providers/Microsoft.EventHub/namespaces/{Event Hub namespace}/authorizationrules/{authorization rule} |  |
| eventHubName | The EventHub name to stream activity logs to |  |
| metricsEnabled | Whether to enable metrics stream to the Log Analytics workspace - True or False | False |
| logsEnabled | Whether to enable logs stream to the Log Analytics workspace - True or False | True |

<br>

<br>

### deploy_network_security_group_diagnostic_setting
| Title | Description |
| ----- | ----------- |
| Name                | deploy_network_security_group_diagnostic_setting |
| DisplayName         |  |
| Description         |  |
| Effect              | [parameters('effect')] |

#### ~ Parameters (deploy_network_security_group_diagnostic_setting)
| Name | Description | Default Value |
| ---- | ----------- | ------------- |
| effect | Enable or disable the execution of the policy | DeployIfNotExists |
| profileName | The diagnostic settings profile name | setbypolicy_Diagnostics |
| workspaceId | Select Log Analytics workspace from dropdown list. If this workspace is outside of the scope of the assignment you must manually grant 'Log Analytics Contributor' permissions (or similar) to the policy assignment's principal ID. |  |
| storageAccountId | The Storage Account Resource Id to send activity logs |  |
| eventHubAuthorizationRuleId | The Event Hub authorization rule Id for Azure Diagnostics. The authorization rule needs to be at Event Hub namespace level. e.g. /subscriptions/{subscription Id}/resourceGroups/{resource group}/providers/Microsoft.EventHub/namespaces/{Event Hub namespace}/authorizationrules/{authorization rule} |  |
| eventHubName | The EventHub name to stream activity logs to |  |
| logsEnabled | Enable Logs - True or False | True |

<br>

<br>

### deploy_network_interface_diagnostic_setting
| Title | Description |
| ----- | ----------- |
| Name                | deploy_network_interface_diagnostic_setting |
| DisplayName         |  |
| Description         |  |
| Effect              | [parameters('effect')] |

#### ~ Parameters (deploy_network_interface_diagnostic_setting)
| Name | Description | Default Value |
| ---- | ----------- | ------------- |
| effect | Enable or disable the execution of the policy | DeployIfNotExists |
| profileName | The diagnostic settings profile name | setbypolicy_Diagnostics |
| workspaceId | Select Log Analytics workspace from dropdown list. If this workspace is outside of the scope of the assignment you must manually grant 'Log Analytics Contributor' permissions (or similar) to the policy assignment's principal ID. |  |
| storageAccountId | The Storage Account Resource Id to send activity logs |  |
| eventHubAuthorizationRuleId | The Event Hub authorization rule Id for Azure Diagnostics. The authorization rule needs to be at Event Hub namespace level. e.g. /subscriptions/{subscription Id}/resourceGroups/{resource group}/providers/Microsoft.EventHub/namespaces/{Event Hub namespace}/authorizationrules/{authorization rule} |  |
| eventHubName | The EventHub name to stream activity logs to |  |
| metricsEnabled | Enable Metrics - True or False | True |

<br>

<br>

### deploy_keyvault_diagnostic_setting
| Title | Description |
| ----- | ----------- |
| Name                | deploy_keyvault_diagnostic_setting |
| DisplayName         |  |
| Description         |  |
| Effect              | [parameters('effect')] |

#### ~ Parameters (deploy_keyvault_diagnostic_setting)
| Name | Description | Default Value |
| ---- | ----------- | ------------- |
| effect | Enable or disable the execution of the policy | DeployIfNotExists |
| profileName | The diagnostic settings profile name | setbypolicy_Diagnostics |
| workspaceId | Select Log Analytics workspace from dropdown list. If this workspace is outside of the scope of the assignment you must manually grant 'Log Analytics Contributor' permissions (or similar) to the policy assignment's principal ID. |  |
| storageAccountId | The Storage Account Resource Id to send activity logs |  |
| eventHubAuthorizationRuleId | The Event Hub authorization rule Id for Azure Diagnostics. The authorization rule needs to be at Event Hub namespace level. e.g. /subscriptions/{subscription Id}/resourceGroups/{resource group}/providers/Microsoft.EventHub/namespaces/{Event Hub namespace}/authorizationrules/{authorization rule} |  |
| eventHubName | The EventHub name to stream activity logs to |  |
| metricsEnabled | Whether to enable metrics stream to the Log Analytics workspace - True or False | False |
| logsEnabled | Whether to enable logs stream to the Log Analytics workspace - True or False | True |

<br>

<br>

### deploy_loadbalancer_diagnostic_setting
| Title | Description |
| ----- | ----------- |
| Name                | deploy_loadbalancer_diagnostic_setting |
| DisplayName         |  |
| Description         |  |
| Effect              | [parameters('effect')] |

#### ~ Parameters (deploy_loadbalancer_diagnostic_setting)
| Name | Description | Default Value |
| ---- | ----------- | ------------- |
| effect | Enable or disable the execution of the policy | DeployIfNotExists |
| profileName | The diagnostic settings profile name | setbypolicy_Diagnostics |
| workspaceId | Select Log Analytics workspace from dropdown list. If this workspace is outside of the scope of the assignment you must manually grant 'Log Analytics Contributor' permissions (or similar) to the policy assignment's principal ID. |  |
| storageAccountId | The Storage Account Resource Id to send activity logs |  |
| eventHubAuthorizationRuleId | The Event Hub authorization rule Id for Azure Diagnostics. The authorization rule needs to be at Event Hub namespace level. e.g. /subscriptions/{subscription Id}/resourceGroups/{resource group}/providers/Microsoft.EventHub/namespaces/{Event Hub namespace}/authorizationrules/{authorization rule} |  |
| eventHubName | The EventHub name to stream activity logs to |  |
| metricsEnabled | Whether to enable metrics stream to the Log Analytics workspace - True or False | False |
| logsEnabled | Whether to enable logs stream to the Log Analytics workspace - True or False | True |

<br>

<br>

### audit_log_analytics_workspace_retention
| Title | Description |
| ----- | ----------- |
| Name                | audit_log_analytics_workspace_retention |
| DisplayName         |  |
| Description         |  |
| Effect              | [parameters('effect')] |

#### ~ Parameters (audit_log_analytics_workspace_retention)
| Name | Description | Default Value |
| ---- | ----------- | ------------- |
| effect | Enable or disable the execution of the policy | AuditIfNotExists |
| workspaceRetentionDays | Log Analytics Workspace should be retained for the specified amount of days. Defaults to 15 months | 456 |

<br>

<br>

### audit_subscription_diagnostic_setting_should_exist
| Title | Description |
| ----- | ----------- |
| Name                | audit_subscription_diagnostic_setting_should_exist |
| DisplayName         |  |
| Description         |  |
| Effect              | [parameters('effect')] |

#### ~ Parameters (audit_subscription_diagnostic_setting_should_exist)
| Name | Description | Default Value |
| ---- | ----------- | ------------- |
| effect | Enable or disable the execution of the policy | AuditIfNotExists |

<br>

<br>

### deploy_application_gateway_diagnostic_setting
| Title | Description |
| ----- | ----------- |
| Name                | deploy_application_gateway_diagnostic_setting |
| DisplayName         |  |
| Description         |  |
| Effect              | [parameters('effect')] |

#### ~ Parameters (deploy_application_gateway_diagnostic_setting)
| Name | Description | Default Value |
| ---- | ----------- | ------------- |
| effect | Enable or disable the execution of the policy | DeployIfNotExists |
| profileName | The diagnostic settings profile name | setbypolicy_Diagnostics |
| workspaceId | Select Log Analytics workspace from dropdown list. If this workspace is outside of the scope of the assignment you must manually grant 'Log Analytics Contributor' permissions (or similar) to the policy assignment's principal ID. |  |
| storageAccountId | The Storage Account Resource Id to send activity logs |  |
| eventHubAuthorizationRuleId | The Event Hub authorization rule Id for Azure Diagnostics. The authorization rule needs to be at Event Hub namespace level. e.g. /subscriptions/{subscription Id}/resourceGroups/{resource group}/providers/Microsoft.EventHub/namespaces/{Event Hub namespace}/authorizationrules/{authorization rule} |  |
| eventHubName | The EventHub name to stream activity logs to |  |
| metricsEnabled | Whether to enable metrics stream to the Log Analytics workspace - True or False | False |
| logsEnabled | Whether to enable logs stream to the Log Analytics workspace - True or False | True |

<br>

<br>

### deploy_eventhub_diagnostic_setting
| Title | Description |
| ----- | ----------- |
| Name                | deploy_eventhub_diagnostic_setting |
| DisplayName         |  |
| Description         |  |
| Effect              | [parameters('effect')] |

#### ~ Parameters (deploy_eventhub_diagnostic_setting)
| Name | Description | Default Value |
| ---- | ----------- | ------------- |
| effect | Enable or disable the execution of the policy | DeployIfNotExists |
| profileName | The diagnostic settings profile name | setbypolicy_Diagnostics |
| workspaceId | Select Log Analytics workspace from dropdown list. If this workspace is outside of the scope of the assignment you must manually grant 'Log Analytics Contributor' permissions (or similar) to the policy assignment's principal ID. |  |
| storageAccountId | The Storage Account Resource Id to send activity logs |  |
| eventHubAuthorizationRuleId | The Event Hub authorization rule Id for Azure Diagnostics. The authorization rule needs to be at Event Hub namespace level. e.g. /subscriptions/{subscription Id}/resourceGroups/{resource group}/providers/Microsoft.EventHub/namespaces/{Event Hub namespace}/authorizationrules/{authorization rule} |  |
| eventHubName | The EventHub name to stream activity logs to |  |
| metricsEnabled | Whether to enable metrics stream to the Log Analytics workspace - True or False | False |
| logsEnabled | Whether to enable logs stream to the Log Analytics workspace - True or False | True |

<br>

<br>

### deploy_expressroute_connection_diagnostic_setting
| Title | Description |
| ----- | ----------- |
| Name                | deploy_expressroute_connection_diagnostic_setting |
| DisplayName         |  |
| Description         |  |
| Effect              | [parameters('effect')] |

#### ~ Parameters (deploy_expressroute_connection_diagnostic_setting)
| Name | Description | Default Value |
| ---- | ----------- | ------------- |
| effect | Enable or disable the execution of the policy | DeployIfNotExists |
| profileName | The diagnostic settings profile name | setbypolicy_Diagnostics |
| workspaceId | Select Log Analytics workspace from dropdown list. If this workspace is outside of the scope of the assignment you must manually grant 'Log Analytics Contributor' permissions (or similar) to the policy assignment's principal ID. |  |
| storageAccountId | The Storage Account Resource Id to send activity logs |  |
| eventHubAuthorizationRuleId | The Event Hub authorization rule Id for Azure Diagnostics. The authorization rule needs to be at Event Hub namespace level. e.g. /subscriptions/{subscription Id}/resourceGroups/{resource group}/providers/Microsoft.EventHub/namespaces/{Event Hub namespace}/authorizationrules/{authorization rule} |  |
| eventHubName | The EventHub name to stream activity logs to |  |
| metricsEnabled | Enable Metrics - True or False | True |
| logsEnabled | Enable Logs - True or False | True |

<br>

<br>

### deploy_expressroute_diagnostic_setting
| Title | Description |
| ----- | ----------- |
| Name                | deploy_expressroute_diagnostic_setting |
| DisplayName         |  |
| Description         |  |
| Effect              | [parameters('effect')] |

#### ~ Parameters (deploy_expressroute_diagnostic_setting)
| Name | Description | Default Value |
| ---- | ----------- | ------------- |
| effect | Enable or disable the execution of the policy | DeployIfNotExists |
| profileName | The diagnostic settings profile name | setbypolicy_Diagnostics |
| workspaceId | Select Log Analytics workspace from dropdown list. If this workspace is outside of the scope of the assignment you must manually grant 'Log Analytics Contributor' permissions (or similar) to the policy assignment's principal ID. |  |
| storageAccountId | The Storage Account Resource Id to send activity logs |  |
| eventHubAuthorizationRuleId | The Event Hub authorization rule Id for Azure Diagnostics. The authorization rule needs to be at Event Hub namespace level. e.g. /subscriptions/{subscription Id}/resourceGroups/{resource group}/providers/Microsoft.EventHub/namespaces/{Event Hub namespace}/authorizationrules/{authorization rule} |  |
| eventHubName | The EventHub name to stream activity logs to |  |
| metricsEnabled | Enable Metrics - True or False | True |
| logsEnabled | Enable Logs - True or False | True |

<br>

<br>

### deploy_firewall_diagnostic_setting
| Title | Description |
| ----- | ----------- |
| Name                | deploy_firewall_diagnostic_setting |
| DisplayName         |  |
| Description         |  |
| Effect              | [parameters('effect')] |

#### ~ Parameters (deploy_firewall_diagnostic_setting)
| Name | Description | Default Value |
| ---- | ----------- | ------------- |
| effect | Enable or disable the execution of the policy | DeployIfNotExists |
| profileName | The diagnostic settings profile name | setbypolicy_Diagnostics |
| workspaceId | Select Log Analytics workspace from dropdown list. If this workspace is outside of the scope of the assignment you must manually grant 'Log Analytics Contributor' permissions (or similar) to the policy assignment's principal ID. |  |
| storageAccountId | The Storage Account Resource Id to send activity logs |  |
| eventHubAuthorizationRuleId | The Event Hub authorization rule Id for Azure Diagnostics. The authorization rule needs to be at Event Hub namespace level. e.g. /subscriptions/{subscription Id}/resourceGroups/{resource group}/providers/Microsoft.EventHub/namespaces/{Event Hub namespace}/authorizationrules/{authorization rule} |  |
| eventHubName | The EventHub name to stream activity logs to |  |
| metricsEnabled | Whether to enable metrics stream to the Log Analytics workspace - True or False | False |
| logsEnabled | Whether to enable logs stream to the Log Analytics workspace - True or False | True |

<br>

<br>

---

## Network

### create_nsg_rule_append
| Title | Description |
| ----- | ----------- |
| Name                | create_nsg_rule_append |
| DisplayName         |  |
| Description         |  |
| Effect              | [parameters('effect')] |

#### ~ Parameters (create_nsg_rule_append)
| Name | Description | Default Value |
| ---- | ----------- | ------------- |
| name |  |  |
| protocol |  |  |
| access |  |  |
| priority |  |  |
| direction |  |  |
| sourcePortRanges |  |  |
| destinationPortRanges |  |  |
| sourceAddressPrefixes |  |  |
| destinationAddressPrefixes |  |  |
| effect | The effect determines what happens when the policy rule is evaluated to match | Append |

<br>

<br>

### deny_nat_rules_firewalls
| Title | Description |
| ----- | ----------- |
| Name                | deny_nat_rules_firewalls |
| DisplayName         |  |
| Description         |  |
| Effect              | [parameters('effect')] |

#### ~ Parameters (deny_nat_rules_firewalls)
| Name | Description | Default Value |
| ---- | ----------- | ------------- |
| effect | The effect determines what happens when the policy rule is evaluated to match | Deny |

<br>

<br>

### deny_nic_on_unapproved_vnet
| Title | Description |
| ----- | ----------- |
| Name                | deny_nic_on_unapproved_vnet |
| DisplayName         |  |
| Description         |  |
| Effect              | [parameters('effect')] |

#### ~ Parameters (deny_nic_on_unapproved_vnet)
| Name | Description | Default Value |
| ---- | ----------- | ------------- |
| effect | The effect determines what happens when the policy rule is evaluated to match | Deny |
| virtualNetworkId | Resource Id of the virtual network. Example: /subscriptions/YourSubscriptionId/resourceGroups/YourResourceGroupName/providers/Microsoft.Network/virtualNetworks/Name |  |

<br>

<br>

### deny_nic_public_ip_on_specific_subnets
| Title | Description |
| ----- | ----------- |
| Name                | deny_nic_public_ip_on_specific_subnets |
| DisplayName         |  |
| Description         |  |
| Effect              | [parameters('effect')] |

#### ~ Parameters (deny_nic_public_ip_on_specific_subnets)
| Name | Description | Default Value |
| ---- | ----------- | ------------- |
| deniedSuffix | NICs attached to a subnet containing this suffix will be unable to attach a Public IP |  |
| effect | The effect determines what happens when the policy rule is evaluated to match | Deny |

<br>

<br>

### deny_nic_public_ip
| Title | Description |
| ----- | ----------- |
| Name                | deny_nic_public_ip |
| DisplayName         |  |
| Description         |  |
| Effect              | [parameters('effect')] |

#### ~ Parameters (deny_nic_public_ip)
| Name | Description | Default Value |
| ---- | ----------- | ------------- |
| effect | The effect determines what happens when the policy rule is evaluated to match | Deny |

<br>

<br>

### deny_nsg_outbound_allow_all
| Title | Description |
| ----- | ----------- |
| Name                | deny_nsg_outbound_allow_all |
| DisplayName         |  |
| Description         |  |
| Effect              | [parameters('effect')] |

#### ~ Parameters (deny_nsg_outbound_allow_all)
| Name | Description | Default Value |
| ---- | ----------- | ------------- |
| effect | The effect determines what happens when the policy rule is evaluated to match | Deny |

<br>

<br>

### deny_nsgs_with_rules_with_source_inbound_any
| Title | Description |
| ----- | ----------- |
| Name                | deny_nsgs_with_rules_with_source_inbound_any |
| DisplayName         |  |
| Description         |  |
| Effect              | [parameters('effect')] |

#### ~ Parameters (deny_nsgs_with_rules_with_source_inbound_any)
| Name | Description | Default Value |
| ---- | ----------- | ------------- |
| effect | The effect determines what happens when the policy rule is evaluated to match | Deny |

<br>

<br>

### deny_pip_if_not_associated_authorised_resource
| Title | Description |
| ----- | ----------- |
| Name                | deny_pip_if_not_associated_authorised_resource |
| DisplayName         |  |
| Description         |  |
| Effect              | [parameters('effect')] |

#### ~ Parameters (deny_pip_if_not_associated_authorised_resource)
| Name | Description | Default Value |
| ---- | ----------- | ------------- |
| effect | The effect determines what happens when the policy rule is evaluated to match | Deny |

<br>

<br>

### deny_unapproved_udr
| Title | Description |
| ----- | ----------- |
| Name                | deny_unapproved_udr |
| DisplayName         |  |
| Description         |  |
| Effect              | [parameters('effect')] |

#### ~ Parameters (deny_unapproved_udr)
| Name | Description | Default Value |
| ---- | ----------- | ------------- |
| allowedHops | A list of the permitted 'next hops' for a UDR |  |
| effect | The effect determines what happens when the policy rule is evaluated to match | Audit |

<br>

<br>

### require_nsg_on_vnet
| Title | Description |
| ----- | ----------- |
| Name                | require_nsg_on_vnet |
| DisplayName         |  |
| Description         |  |
| Effect              | [parameters('effect')] |

#### ~ Parameters (require_nsg_on_vnet)
| Name | Description | Default Value |
| ---- | ----------- | ------------- |
| allowedRanges | Provide the list of approved IP ranges for NSGs |  |
| effect | The effect determines what happens when the policy rule is evaluated to match | Audit |

<br>

<br>

### restrict_vnet_peering
| Title | Description |
| ----- | ----------- |
| Name                | restrict_vnet_peering |
| DisplayName         |  |
| Description         |  |
| Effect              | [parameters('effect')] |

#### ~ Parameters (restrict_vnet_peering)
| Name | Description | Default Value |
| ---- | ----------- | ------------- |
| trustedVnetIds | Trusted vNet IDs |  |
| effect | The effect determines what happens when the policy rule is evaluated to match | Audit |

<br>

<br>

### deny_unapproved_udr_hop_type
| Title | Description |
| ----- | ----------- |
| Name                | deny_unapproved_udr_hop_type |
| DisplayName         |  |
| Description         |  |
| Effect              | [parameters('effect')] |

#### ~ Parameters (deny_unapproved_udr_hop_type)
| Name | Description | Default Value |
| ---- | ----------- | ------------- |
| allowedHopType1 | A permitted hop type for a UDR |  |
| allowedHopType2 | A permitted hop type for a UDR |  |
| allowedHopType3 | A permitted hop type for a UDR |  |
| effect | The effect determines what happens when the policy rule is evaluated to match | Audit |

<br>

<br>

---

## Security Center

### auto_enroll_subscriptions
| Title | Description |
| ----- | ----------- |
| Name                | auto_enroll_subscriptions |
| DisplayName         |  |
| Description         |  |
| Effect              | [parameters('effect')] |

#### ~ Parameters (auto_enroll_subscriptions)
| Name | Description | Default Value |
| ---- | ----------- | ------------- |
| effect | Enable or disable the execution of the policy | DeployIfNotExists |
| pricingTier | ASC Pricing Tier | standard |

<br>

<br>

### auto_provision_log_analytics_agent_custom_workspace
| Title | Description |
| ----- | ----------- |
| Name                | auto_provision_log_analytics_agent_custom_workspace |
| DisplayName         |  |
| Description         |  |
| Effect              | [parameters('effect')] |

#### ~ Parameters (auto_provision_log_analytics_agent_custom_workspace)
| Name | Description | Default Value |
| ---- | ----------- | ------------- |
| effect | Enable or disable the execution of the policy | DeployIfNotExists |
| workspaceId | Auto provision the Log Analytics agent on your subscriptions to monitor and collect security data using a custom workspace. |  |

<br>

<br>

### auto_set_contact_details
| Title | Description |
| ----- | ----------- |
| Name                | auto_set_contact_details |
| DisplayName         |  |
| Description         |  |
| Effect              | [parameters('effect')] |

#### ~ Parameters (auto_set_contact_details)
| Name | Description | Default Value |
| ---- | ----------- | ------------- |
| effect | Enable or disable the execution of the policy | DeployIfNotExists |
| securityContactsEmail | The email of the Security Center Contact. |  |
| securityContactsPhone | The phone number of the Security Center Contact. |  |

<br>

<br>

### enable_vulnerability_vm_assessments
| Title | Description |
| ----- | ----------- |
| Name                | enable_vulnerability_vm_assessments |
| DisplayName         |  |
| Description         |  |
| Effect              | [parameters('effect')] |

#### ~ Parameters (enable_vulnerability_vm_assessments)
| Name | Description | Default Value |
| ---- | ----------- | ------------- |
| effect | Enable or disable the execution of the policy | DeployIfNotExists |

<br>

<br>

### export_asc_alerts_and_recommendations_to_eventhub
| Title | Description |
| ----- | ----------- |
| Name                | export_asc_alerts_and_recommendations_to_eventhub |
| DisplayName         |  |
| Description         |  |
| Effect              | [parameters('effect')] |

#### ~ Parameters (export_asc_alerts_and_recommendations_to_eventhub)
| Name | Description | Default Value |
| ---- | ----------- | ------------- |
| effect | Enable or disable the execution of the policy | DeployIfNotExists |
| resourceGroupName | The resource group name where the export to Event Hub configuration is created. If you enter a name for a resource group that doesn't exist, it'll be created in the subscription. Note that each resource group can only have one export to Event Hub configured. | policy-export-asc-alerts |
| resourceGroupLocation | The location where the resource group and the export to Event Hub configuration are created. | uksouth |
| exportedDataTypes | The data types to be exported. Example: Security recommendations;Security alerts;Secure scores;Secure score controls; | Security recommendations Security alerts Overall secure score Secure score controls |
| recommendationNames | Applicable only for export of security recommendations. To export all recommendations, leave this empty. To export specific recommendations, enter a list of recommendation IDs separated by semicolons (';'). Recommendation IDs are available through the Assessments API (https://docs.microsoft.com/rest/api/securitycenter/assessments), or Azure Resource Graph Explorer (https://portal.azure.com/#blade/HubsExtension/ArgQueryBlade), choose securityresources and microsoft.security/assessments. |  |
| recommendationSeverities | Applicable only for export of security recommendations. Determines recommendation severities. Example: High;Medium;Low; | High Medium Low |
| isSecurityFindingsEnabled | Security findings are results from vulnerability assessment solutions, and can be thought of as 'sub' recommendations grouped into a 'parent' recommendation. | True |
| secureScoreControlsNames | Applicable only for export of secure score controls. To export all secure score controls, leave this empty. To export specific secure score controls, enter a list of secure score controls IDs separated by semicolons (';'). Secure score controls IDs are available through the Secure score controls API (https://docs.microsoft.com/rest/api/securitycenter/securescorecontrols), or Azure Resource Graph Explorer (https://portal.azure.com/#blade/HubsExtension/ArgQueryBlade), choose securityresources and microsoft.security/securescores/securescorecontrols. |  |
| alertSeverities | Applicable only for export of security alerts. Determines alert severities. Example: High;Medium;Low; | High Medium Low |
| eventHubDetails | The Event Hub details of where the data should be exported to: Subscription, Event Hub Namespace, Event Hub, and Authorizations rules with 'Send' claim. If you do not already have an event hub, visit Event Hubs to create one (https://portal.azure.com/#blade/HubsExtension/BrowseResource/resourceType/Microsoft.EventHub%2Fnamespaces). |  |

<br>

<br>

### export_asc_alerts_and_recommendations_to_log_analytics
| Title | Description |
| ----- | ----------- |
| Name                | export_asc_alerts_and_recommendations_to_log_analytics |
| DisplayName         |  |
| Description         |  |
| Effect              | [parameters('effect')] |

#### ~ Parameters (export_asc_alerts_and_recommendations_to_log_analytics)
| Name | Description | Default Value |
| ---- | ----------- | ------------- |
| effect | Enable or disable the execution of the policy | DeployIfNotExists |
| resourceGroupName | The resource group name where the export to Log Analytics configuration is created. If you enter a name for a resource group that doesn't exist, it'll be created in the subscription. Note that each resource group can only have one export to Log Analytics configured. | policy-export-asc-alerts |
| resourceGroupLocation | The location where the resource group and the export to Log Analytics configuration are created. | uksouth |
| exportedDataTypes | The data types to be exported. Example: Security recommendations;Security alerts;Secure scores;Secure score controls; | Security recommendations Security alerts Overall secure score Secure score controls |
| recommendationNames | Applicable only for export of security recommendations. To export all recommendations, leave this empty. To export specific recommendations, enter a list of recommendation IDs separated by semicolons (';'). Recommendation IDs are available through the Assessments API (https://docs.microsoft.com/rest/api/securitycenter/assessments), or Azure Resource Graph Explorer (https://portal.azure.com/#blade/HubsExtension/ArgQueryBlade), choose securityresources and microsoft.security/assessments. |  |
| recommendationSeverities | Applicable only for export of security recommendations. Determines recommendation severities. Example: High;Medium;Low; | High Medium Low |
| isSecurityFindingsEnabled | Security findings are results from vulnerability assessment solutions, and can be thought of as 'sub' recommendations grouped into a 'parent' recommendation. | True |
| secureScoreControlsNames | Applicable only for export of secure score controls. To export all secure score controls, leave this empty. To export specific secure score controls, enter a list of secure score controls IDs separated by semicolons (';'). Secure score controls IDs are available through the Secure score controls API (https://docs.microsoft.com/rest/api/securitycenter/securescorecontrols), or Azure Resource Graph Explorer (https://portal.azure.com/#blade/HubsExtension/ArgQueryBlade), choose securityresources and microsoft.security/securescores/securescorecontrols. |  |
| alertSeverities | Applicable only for export of security alerts. Determines alert severities. Example: High;Medium;Low; | High Medium Low |
| workspaceId | Auto provision the Log Analytics agent on your subscriptions to monitor and collect security data using a custom workspace. |  |

<br>

<br>

---

## Storage

### storage_enforce_https
| Title | Description |
| ----- | ----------- |
| Name                | storage_enforce_https |
| DisplayName         |  |
| Description         |  |
| Effect              | [parameters('effect')] |

#### ~ Parameters (storage_enforce_https)
| Name | Description | Default Value |
| ---- | ----------- | ------------- |
| effect | The effect determines what happens when the policy rule is evaluated to match | Deny |

<br>

<br>

### storage_enforce_minimum_tls1_2
| Title | Description |
| ----- | ----------- |
| Name                | storage_enforce_minimum_tls1_2 |
| DisplayName         |  |
| Description         |  |
| Effect              | [parameters('effect')] |

#### ~ Parameters (storage_enforce_minimum_tls1_2)
| Name | Description | Default Value |
| ---- | ----------- | ------------- |
| effect | The effect determines what happens when the policy rule is evaluated to match | Deny |

<br>

<br>

---

## Tags

### add_replace_resource_group_tag_key_modify
| Title | Description |
| ----- | ----------- |
| Name                | add_replace_resource_group_tag_key_modify |
| DisplayName         |  |
| Description         |  |
| Effect              | [parameters('effect')] |

#### ~ Parameters (add_replace_resource_group_tag_key_modify)
| Name | Description | Default Value |
| ---- | ----------- | ------------- |
| effect | The effect determines what happens when the policy rule is evaluated to match | Modify |

<br>

<br>

### inherit_resource_group_tags_append
| Title | Description |
| ----- | ----------- |
| Name                | inherit_resource_group_tags_append |
| DisplayName         |  |
| Description         |  |
| Effect              | [parameters('effect')] |

#### ~ Parameters (inherit_resource_group_tags_append)
| Name | Description | Default Value |
| ---- | ----------- | ------------- |
| tagName | Name of the tag, such as 'environment' |  |
| effect | The effect determines what happens when the policy rule is evaluated to match | Append |

<br>

<br>

### inherit_resource_group_tags_modify
| Title | Description |
| ----- | ----------- |
| Name                | inherit_resource_group_tags_modify |
| DisplayName         |  |
| Description         |  |
| Effect              | [parameters('effect')] |

#### ~ Parameters (inherit_resource_group_tags_modify)
| Name | Description | Default Value |
| ---- | ----------- | ------------- |
| tagName | Name of the tag, such as 'environment' |  |
| effect | The effect determines what happens when the policy rule is evaluated to match | Modify |

<br>

<br>

### require_resource_group_tags
| Title | Description |
| ----- | ----------- |
| Name                | require_resource_group_tags |
| DisplayName         |  |
| Description         |  |
| Effect              | [parameters('effect')] |

#### ~ Parameters (require_resource_group_tags)
| Name | Description | Default Value |
| ---- | ----------- | ------------- |
| tagName | Name of the tag, such as 'environment' |  |
| effect | The effect determines what happens when the policy rule is evaluated to match | Audit |

<br>

<br>

---
