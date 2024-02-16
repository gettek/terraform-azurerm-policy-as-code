
# Custom Policy Definition Library
Compile time: 02/15/2024 11:33:43 UTC
Example custom definitions located in the local library

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

### 📜 [onboard_to_automation_dsc_linux](./Automation/onboard_to_automation_dsc_linux.json)
| Title | Description |
| ----- | ----------- |
| Name                | onboard_to_automation_dsc_linux |
| DisplayName         | Onboard Azure VM and Arc connected Linux machines to Azure Automation DSC |
| Description         | Deploys the DSC extension to onboard Linux nodes to Azure Automation DSC. Assigns a configuration. |
| Version             | 2.0.0 |
| Effect              | [parameters('effect')] |

#### 🧮 ~ Parameters
| Name | Description | Default Value | Allowed Values |
| ---- | ----------- | ------------- | -------------- |
| effect | Enable or disable the execution of the policy | DeployIfNotExists | DeployIfNotExists Disabled |
| automationAccountId | Automation Account Id. If this account is outside of the scope of the assignment you must manually grant 'Contributor' permissions (or similar) on the Automation account to the policy assignment's principal ID. |  |  |
| nxNodeConfigurationName | Specifies the node configuration in the Automation account to assign to the node. NOTE: will auto-suffix '.localhost'. |  |  |
| nodeConfigurationMode | Specifies the mode for LCM. Valid options include ApplyOnly, ApplyandMonitor, and ApplyandAutoCorrect. The default value is ApplyAndAutoCorrect. | ApplyAndAutoCorrect | ApplyAndAutoCorrect applyAndMonitor ApplyOnly |
| listOfImageIdToInclude_linux | Example value: '/subscriptions/<subscriptionId>/resourceGroups/YourResourceGroup/providers/Microsoft.Compute/images/ContosoStdImage' |  |  |

<br>

<br>

### 📜 [onboard_to_automation_dsc_windows](./Automation/onboard_to_automation_dsc_windows.json)
| Title | Description |
| ----- | ----------- |
| Name                | onboard_to_automation_dsc_windows |
| DisplayName         | Onboard Azure VM and Arc connected Windows machines to Azure Automation DSC |
| Description         | Deploys the DSC extension to onboard Windows nodes to Azure Automation DSC. Assigns a configuration. |
| Version             | 2.0.0 |
| Effect              | [parameters('effect')] |

#### 🧮 ~ Parameters
| Name | Description | Default Value | Allowed Values |
| ---- | ----------- | ------------- | -------------- |
| effect | Enable or disable the execution of the policy | DeployIfNotExists | DeployIfNotExists Disabled |
| automationAccountId | Automation Account Id. If this account is outside of the scope of the assignment you must manually grant 'Contributor' permissions (or similar) on the Automation account to the policy assignment's principal ID. |  |  |
| nodeConfigurationName | Specifies the node configuration in the Automation account to assign to the node. NOTE: will auto-suffix '.localhost'. |  |  |
| nodeConfigurationMode | Specifies the mode for LCM. Valid options include ApplyOnly, ApplyandMonitor, and ApplyandAutoCorrect. The default value is ApplyAndAutoCorrect. | ApplyAndAutoCorrect | ApplyAndAutoCorrect applyAndMonitor ApplyOnly |
| listOfImageIdToInclude_windows | Example value: '/subscriptions/<subscriptionId>/resourceGroups/YourResourceGroup/providers/Microsoft.Compute/images/ContosoStdImage' |  |  |

<br>

<br>

---

## Compute

### 📜 [deploy_linux_lad_vm_agent](./Compute/deploy_linux_lad_vm_agent.json)
| Title | Description |
| ----- | ----------- |
| Name                | deploy_linux_lad_vm_agent |
| DisplayName         |  |
| Description         |  |
| Version             |  |
| Effect              | [parameters('effect')] |

#### 🧮 ~ Parameters
| Name | Description | Default Value | Allowed Values |
| ---- | ----------- | ------------- | -------------- |
| effect | Enable or disable the execution of the policy | DeployIfNotExists | DeployIfNotExists Disabled |
| diagnosticsStorageAccountName | The Storage Account Id to send diagnostic logs |  |  |
| diagnosticsStorageAccountSas | The Storage Account SAS Token to send diagnostic logs |  |  |
| listOfImageIdToInclude_linux | Example value: '/subscriptions/<subscriptionId>/resourceGroups/YourResourceGroup/providers/Microsoft.Compute/images/ContosoStdImage' |  |  |

<br>

<br>

### 📜 [deploy_linux_lad_vmss_agent](./Compute/deploy_linux_lad_vmss_agent.json)
| Title | Description |
| ----- | ----------- |
| Name                | deploy_linux_lad_vmss_agent |
| DisplayName         |  |
| Description         |  |
| Version             |  |
| Effect              | [parameters('effect')] |

#### 🧮 ~ Parameters
| Name | Description | Default Value | Allowed Values |
| ---- | ----------- | ------------- | -------------- |
| effect | Enable or disable the execution of the policy | DeployIfNotExists | DeployIfNotExists Disabled |
| diagnosticsStorageAccountName | The Storage Account Id to send diagnostic logs |  |  |
| diagnosticsStorageAccountSas | The Storage Account SAS Token to send diagnostic logs |  |  |
| eventHubUrl | The EventHub Url to stream diagnostic logs to. e.g. https://myeventhub-ns.servicebus.windows.net/diageventhub |  |  |
| eventHubSASToken | The Event Hub Shared Access Token |  |  |
| listOfImageIdToInclude_linux | Example value: '/subscriptions/<subscriptionId>/resourceGroups/YourResourceGroup/providers/Microsoft.Compute/images/ContosoStdImage' |  |  |

<br>

<br>

### 📜 [deploy_linux_log_analytics_vm_agent](./Compute/deploy_linux_log_analytics_vm_agent.json)
| Title | Description |
| ----- | ----------- |
| Name                | deploy_linux_log_analytics_vm_agent |
| DisplayName         |  |
| Description         |  |
| Version             |  |
| Effect              | [parameters('effect')] |

#### 🧮 ~ Parameters
| Name | Description | Default Value | Allowed Values |
| ---- | ----------- | ------------- | -------------- |
| effect | Enable or disable the execution of the policy | DeployIfNotExists | DeployIfNotExists Disabled |
| workspaceId | Specify the Log Analytics Workspace Id the agent should be connected to. If this workspace is outside of the scope of the assignment you must manually grant 'Log Analytics Contributor' permissions (or similar) to the policy assignment's principal ID. |  |  |
| listOfImageIdToInclude_linux | Example value: '/subscriptions/<subscriptionId>/resourceGroups/YourResourceGroup/providers/Microsoft.Compute/images/ContosoStdImage' |  |  |

<br>

<br>

### 📜 [deploy_linux_log_analytics_vmss_agent](./Compute/deploy_linux_log_analytics_vmss_agent.json)
| Title | Description |
| ----- | ----------- |
| Name                | deploy_linux_log_analytics_vmss_agent |
| DisplayName         |  |
| Description         |  |
| Version             |  |
| Effect              | [parameters('effect')] |

#### 🧮 ~ Parameters
| Name | Description | Default Value | Allowed Values |
| ---- | ----------- | ------------- | -------------- |
| effect | Enable or disable the execution of the policy | DeployIfNotExists | DeployIfNotExists Disabled |
| workspaceId | Specify the Log Analytics Workspace Id the agent should be connected to. If this workspace is outside of the scope of the assignment you must manually grant 'Log Analytics Contributor' permissions (or similar) to the policy assignment's principal ID. |  |  |
| listOfImageIdToInclude_linux | Example value: '/subscriptions/<subscriptionId>/resourceGroups/YourResourceGroup/providers/Microsoft.Compute/images/ContosoStdImage' |  |  |

<br>

<br>

### 📜 [deploy_windows_log_analytics_vm_agent](./Compute/deploy_windows_log_analytics_vm_agent.json)
| Title | Description |
| ----- | ----------- |
| Name                | deploy_windows_log_analytics_vm_agent |
| DisplayName         |  |
| Description         |  |
| Version             |  |
| Effect              | [parameters('effect')] |

#### 🧮 ~ Parameters
| Name | Description | Default Value | Allowed Values |
| ---- | ----------- | ------------- | -------------- |
| effect | Enable or disable the execution of the policy | DeployIfNotExists | DeployIfNotExists Disabled |
| workspaceId | Specify the Log Analytics Workspace Id the agent should be connected to. If this workspace is outside of the scope of the assignment you must manually grant 'Log Analytics Contributor' permissions (or similar) to the policy assignment's principal ID. |  |  |
| listOfImageIdToInclude_windows | Example value: '/subscriptions/<subscriptionId>/resourceGroups/YourResourceGroup/providers/Microsoft.Compute/images/ContosoStdImage' |  |  |

<br>

<br>

### 📜 [deploy_windows_log_analytics_vmss_agent](./Compute/deploy_windows_log_analytics_vmss_agent.json)
| Title | Description |
| ----- | ----------- |
| Name                | deploy_windows_log_analytics_vmss_agent |
| DisplayName         |  |
| Description         |  |
| Version             |  |
| Effect              | [parameters('effect')] |

#### 🧮 ~ Parameters
| Name | Description | Default Value | Allowed Values |
| ---- | ----------- | ------------- | -------------- |
| effect | Enable or disable the execution of the policy | DeployIfNotExists | DeployIfNotExists Disabled |
| workspaceId | Specify the Log Analytics Workspace Id the agent should be connected to. If this workspace is outside of the scope of the assignment you must manually grant 'Log Analytics Contributor' permissions (or similar) to the policy assignment's principal ID. |  |  |
| listOfImageIdToInclude_windows | Example value: '/subscriptions/<subscriptionId>/resourceGroups/YourResourceGroup/providers/Microsoft.Compute/images/ContosoStdImage' |  |  |

<br>

<br>

### 📜 [deploy_windows_wad_vm_agent](./Compute/deploy_windows_wad_vm_agent.json)
| Title | Description |
| ----- | ----------- |
| Name                | deploy_windows_wad_vm_agent |
| DisplayName         |  |
| Description         |  |
| Version             |  |
| Effect              | [parameters('effect')] |

#### 🧮 ~ Parameters
| Name | Description | Default Value | Allowed Values |
| ---- | ----------- | ------------- | -------------- |
| effect | Enable or disable the execution of the policy | DeployIfNotExists | DeployIfNotExists Disabled |
| diagnosticsStorageAccountName | The Storage Account Id to send diagnostic logs |  |  |
| diagnosticsStorageAccountId | The Storage Account Id to send diagnostic logs |  |  |
| eventHubSharedAccessKeyId | The Event Hub Shared Access Key Key Resource Id. |  |  |
| eventHubSharedAccessKeyName | The Event Hub Shared Access Key Name. Defaults to the Root Key | RootManageSharedAccessKey |  |
| eventHubUrl | The EventHub Url to stream diagnostic logs to. e.g. https://myeventhub-ns.servicebus.windows.net/diageventhub |  |  |
| listOfImageIdToInclude_windows | Example value: '/subscriptions/<subscriptionId>/resourceGroups/YourResourceGroup/providers/Microsoft.Compute/images/ContosoStdImage' |  |  |

<br>

<br>

### 📜 [deploy_windows_wad_vmss_agent](./Compute/deploy_windows_wad_vmss_agent.json)
| Title | Description |
| ----- | ----------- |
| Name                | deploy_windows_wad_vmss_agent |
| DisplayName         |  |
| Description         |  |
| Version             |  |
| Effect              | [parameters('effect')] |

#### 🧮 ~ Parameters
| Name | Description | Default Value | Allowed Values |
| ---- | ----------- | ------------- | -------------- |
| effect | Enable or disable the execution of the policy | DeployIfNotExists | DeployIfNotExists Disabled |
| diagnosticsStorageAccountName | The Storage Account Id to send diagnostic logs |  |  |
| diagnosticsStorageAccountId | The Storage Account Id to send diagnostic logs |  |  |
| eventHubSharedAccessKeyId | The Event Hub Shared Access Key Key Resource Id. |  |  |
| eventHubSharedAccessKeyName | The Event Hub Shared Access Key Name. Defaults to the Root Key | RootManageSharedAccessKey |  |
| eventHubUrl | The EventHub Url to stream diagnostic logs to. e.g. https://myeventhub-ns.servicebus.windows.net/diageventhub |  |  |
| listOfImageIdToInclude_windows | Example value: '/subscriptions/<subscriptionId>/resourceGroups/YourResourceGroup/providers/Microsoft.Compute/images/ContosoStdImage' |  |  |

<br>

<br>

### 📜 [preview_deploy_linux_azure_monitor_vm_agent](./Compute/preview_deploy_linux_azure_monitor_vm_agent.json)
| Title | Description |
| ----- | ----------- |
| Name                | preview_deploy_linux_azure_monitor_vm_agent |
| DisplayName         |  |
| Description         |  |
| Version             |  |
| Effect              | deployIfNotExists |

#### 🧮 ~ Parameters
| Name | Description | Default Value | Allowed Values |
| ---- | ----------- | ------------- | -------------- |
| effect | Enable or disable the execution of the policy | DeployIfNotExists | DeployIfNotExists Disabled |
| listOfImageIdToInclude_linux | Example value: '/subscriptions/<subscriptionId>/resourceGroups/YourResourceGroup/providers/Microsoft.Compute/images/ContosoStdImage' |  |  |

<br>

<br>

### 📜 [preview_deploy_windows_azure_monitor_vm_agent](./Compute/preview_deploy_windows_azure_monitor_vm_agent.json)
| Title | Description |
| ----- | ----------- |
| Name                | preview_deploy_windows_azure_monitor_vm_agent |
| DisplayName         |  |
| Description         |  |
| Version             |  |
| Effect              | [parameters('effect')] |

#### 🧮 ~ Parameters
| Name | Description | Default Value | Allowed Values |
| ---- | ----------- | ------------- | -------------- |
| effect | Enable or disable the execution of the policy | DeployIfNotExists | DeployIfNotExists Disabled |
| listOfImageIdToInclude_windows | Example value: '/subscriptions/<subscriptionId>/resourceGroups/YourResourceGroup/providers/Microsoft.Compute/images/ContosoStdImage' |  |  |

<br>

<br>

---

## General

### 📜 [deny_resource_types](./General/deny_resource_types.json)
| Title | Description |
| ----- | ----------- |
| Name                | deny_resource_types |
| DisplayName         |  |
| Description         |  |
| Version             |  |
| Effect              | [parameters('effect')] |

#### 🧮 ~ Parameters
| Name | Description | Default Value | Allowed Values |
| ---- | ----------- | ------------- | -------------- |
| listOfResourceTypesNotAllowed | The list of resource types that cannot be deployed. |  |  |
| effect | The effect determines what happens when the policy rule is evaluated to match | Audit | Audit Deny Disabled |

<br>

<br>

### 📜 [whitelist_regions](./General/whitelist_regions.json)
| Title | Description |
| ----- | ----------- |
| Name                | whitelist_regions |
| DisplayName         |  |
| Description         |  |
| Version             |  |
| Effect              | [parameters('effect')] |

#### 🧮 ~ Parameters
| Name | Description | Default Value | Allowed Values |
| ---- | ----------- | ------------- | -------------- |
| listOfRegionsAllowed | The list of regions where resources can be deployed. | UK South UK West |  |
| effect | The effect determines what happens when the policy rule is evaluated to match | Audit | Audit Deny Disabled |

<br>

<br>

### 📜 [whitelist_resources](./General/whitelist_resources.json)
| Title | Description |
| ----- | ----------- |
| Name                | whitelist_resources |
| DisplayName         |  |
| Description         |  |
| Version             |  |
| Effect              | [parameters('effect')] |

#### 🧮 ~ Parameters
| Name | Description | Default Value | Allowed Values |
| ---- | ----------- | ------------- | -------------- |
| listOfResourceTypesAllowed | The list of resource types that can be deployed. |  |  |
| effect | The effect determines what happens when the policy rule is evaluated to match | Audit | Audit Deny Disabled |

<br>

<br>

---

## Guest Configuration

### 📜 [nxLAMPServer_2.1.2](./Guest%20Configuration/nxLAMPServer_2.1.2.json)
| Title | Description |
| ----- | ----------- |
| Name                | dfaa1524-3971-46f0-8c33-a96b6070d953 |
| DisplayName         | [CGC]: nxLAMPServer v2.1.2 |
| Description         | VM Custom Machine Config: nxLAMPServer v2.1.2 |
| Version             | 2.1.2 |
| Effect              | deployIfNotExists |

#### 🧮 ~ Parameters
| Name | Description | Default Value | Allowed Values |
| ---- | ----------- | ------------- | -------------- |
| IncludeArcMachines | By selecting this option, you agree to be charged monthly per Arc connected machine. | false | true false |

<br>

<br>

### 📜 [WindowsSecurityBaseline2016_1.1.0](./Guest%20Configuration/WindowsSecurityBaseline2016_1.1.0.json)
| Title | Description |
| ----- | ----------- |
| Name                | b272797e-bc0e-4db7-ba24-99819c65cd5b |
| DisplayName         | [CGC]: WindowsSecurityBaseline2016 v1.1.0 |
| Description         | VM Custom Machine Config: WindowsSecurityBaseline2016 v1.1.0 |
| Version             | 1.1.0 |
| Effect              | deployIfNotExists |

#### 🧮 ~ Parameters
| Name | Description | Default Value | Allowed Values |
| ---- | ----------- | ------------- | -------------- |
| IncludeArcMachines | By selecting this option, you agree to be charged monthly per Arc connected machine. | false | true false |

<br>

<br>

---

## Monitoring

### 📜 [deploy_loadbalancer_diagnostic_setting](./Monitoring/deploy_loadbalancer_diagnostic_setting.json)
| Title | Description |
| ----- | ----------- |
| Name                | deploy_loadbalancer_diagnostic_setting |
| DisplayName         | Deploy Diagnostic Settings for Load Balancers to a Log Analytics workspace |
| Description         | Deploys the diagnostic settings for Load Balancers to stream to a regional Log Analytics workspace when any Load Balancer which is missing this diagnostic settings is created or updated. |
| Version             |  |
| Effect              | [parameters('effect')] |

#### 🧮 ~ Parameters
| Name | Description | Default Value | Allowed Values |
| ---- | ----------- | ------------- | -------------- |
| effect | Enable or disable the execution of the policy | DeployIfNotExists | AuditIfNotExists AuditIfNotExists DeployIfNotExists Disabled |
| profileName | The diagnostic settings profile name | setbypolicy_Diagnostics |  |
| workspaceId | Select Log Analytics workspace from dropdown list. If this workspace is outside of the scope of the assignment you must manually grant 'Log Analytics Contributor' permissions (or similar) to the policy assignment's principal ID. |  |  |
| storageAccountId | The Storage Account Resource Id to send activity logs |  |  |
| eventHubAuthorizationRuleId | The Event Hub authorization rule Id for Azure Diagnostics. The authorization rule needs to be at Event Hub namespace level. e.g. /subscriptions/{subscription Id}/resourceGroups/{resource group}/providers/Microsoft.EventHub/namespaces/{Event Hub namespace}/authorizationrules/{authorization rule} |  |  |
| eventHubName | The EventHub name to stream activity logs to |  |  |
| metricsEnabled | Whether to enable metrics stream to the Log Analytics workspace - True or False | False | True False |
| logsEnabled | Whether to enable logs stream to the Log Analytics workspace - True or False | True | True False |

<br>

<br>

### 📜 [deploy_network_interface_diagnostic_setting](./Monitoring/deploy_network_interface_diagnostic_setting.json)
| Title | Description |
| ----- | ----------- |
| Name                | deploy_network_interface_diagnostic_setting |
| DisplayName         | Deploy Diagnostic Settings for Network Interfaces to a Log Analytics workspace |
| Description         | Deploys the diagnostic settings for Network Interfaces to stream to a regional Log Analytics workspace when any Network Interface which is missing this diagnostic settings is created or updated. |
| Version             |  |
| Effect              | [parameters('effect')] |

#### 🧮 ~ Parameters
| Name | Description | Default Value | Allowed Values |
| ---- | ----------- | ------------- | -------------- |
| effect | Enable or disable the execution of the policy | DeployIfNotExists | AuditIfNotExists DeployIfNotExists Disabled |
| profileName | The diagnostic settings profile name | setbypolicy_Diagnostics |  |
| workspaceId | Select Log Analytics workspace from dropdown list. If this workspace is outside of the scope of the assignment you must manually grant 'Log Analytics Contributor' permissions (or similar) to the policy assignment's principal ID. |  |  |
| storageAccountId | The Storage Account Resource Id to send activity logs |  |  |
| eventHubAuthorizationRuleId | The Event Hub authorization rule Id for Azure Diagnostics. The authorization rule needs to be at Event Hub namespace level. e.g. /subscriptions/{subscription Id}/resourceGroups/{resource group}/providers/Microsoft.EventHub/namespaces/{Event Hub namespace}/authorizationrules/{authorization rule} |  |  |
| eventHubName | The EventHub name to stream activity logs to |  |  |
| metricsEnabled | Enable Metrics - True or False | True | True False |

<br>

<br>

### 📜 [deploy_network_security_group_diagnostic_setting](./Monitoring/deploy_network_security_group_diagnostic_setting.json)
| Title | Description |
| ----- | ----------- |
| Name                | deploy_network_security_group_diagnostic_setting |
| DisplayName         | Deploy Diagnostic Settings for Network Security Groups to a Log Analytics workspace |
| Description         | Deploys the diagnostic settings for Network Security Groups to stream to a regional Log Analytics workspace when any Network Security Group which is missing this diagnostic settings is created or updated. |
| Version             |  |
| Effect              | [parameters('effect')] |

#### 🧮 ~ Parameters
| Name | Description | Default Value | Allowed Values |
| ---- | ----------- | ------------- | -------------- |
| effect | Enable or disable the execution of the policy | DeployIfNotExists | AuditIfNotExists DeployIfNotExists Disabled |
| profileName | The diagnostic settings profile name | setbypolicy_Diagnostics |  |
| workspaceId | Select Log Analytics workspace from dropdown list. If this workspace is outside of the scope of the assignment you must manually grant 'Log Analytics Contributor' permissions (or similar) to the policy assignment's principal ID. |  |  |
| storageAccountId | The Storage Account Resource Id to send activity logs |  |  |
| eventHubAuthorizationRuleId | The Event Hub authorization rule Id for Azure Diagnostics. The authorization rule needs to be at Event Hub namespace level. e.g. /subscriptions/{subscription Id}/resourceGroups/{resource group}/providers/Microsoft.EventHub/namespaces/{Event Hub namespace}/authorizationrules/{authorization rule} |  |  |
| eventHubName | The EventHub name to stream activity logs to |  |  |
| logsEnabled | Enable Logs - True or False | True | True False |

<br>

<br>

### 📜 [deploy_public_ip_diagnostic_setting](./Monitoring/deploy_public_ip_diagnostic_setting.json)
| Title | Description |
| ----- | ----------- |
| Name                | deploy_public_ip_diagnostic_setting |
| DisplayName         | Deploy Diagnostic Settings for Public IPs to a Log Analytics workspace |
| Description         | Deploys the diagnostic settings for Public IPs to stream to a regional Log Analytics workspace when any Public IP which is missing this diagnostic settings is created or updated. |
| Version             |  |
| Effect              | [parameters('effect')] |

#### 🧮 ~ Parameters
| Name | Description | Default Value | Allowed Values |
| ---- | ----------- | ------------- | -------------- |
| effect | Enable or disable the execution of the policy | DeployIfNotExists | AuditIfNotExists DeployIfNotExists Disabled |
| profileName | The diagnostic settings profile name | setbypolicy_Diagnostics |  |
| workspaceId | Select Log Analytics workspace from dropdown list. If this workspace is outside of the scope of the assignment you must manually grant 'Log Analytics Contributor' permissions (or similar) to the policy assignment's principal ID. |  |  |
| storageAccountId | The Storage Account Resource Id to send activity logs |  |  |
| eventHubAuthorizationRuleId | The Event Hub authorization rule Id for Azure Diagnostics. The authorization rule needs to be at Event Hub namespace level. e.g. /subscriptions/{subscription Id}/resourceGroups/{resource group}/providers/Microsoft.EventHub/namespaces/{Event Hub namespace}/authorizationrules/{authorization rule} |  |  |
| eventHubName | The EventHub name to stream activity logs to |  |  |
| metricsEnabled | Enable Metrics - True or False | True | True False |
| logsEnabled | Enable Logs - True or False | True | True False |

<br>

<br>

### 📜 [deploy_storage_account_diagnostic_setting](./Monitoring/deploy_storage_account_diagnostic_setting.json)
| Title | Description |
| ----- | ----------- |
| Name                | deploy_storage_account_diagnostic_setting |
| DisplayName         | Deploy Diagnostic Settings for Azure Storage, including blobs, files, tables, and queues to a Log Analytics workspace |
| Description         | Deploys the diagnostic settings for Azure Storage, including blobs, files, tables, and queues to stream to a regional Log Analytics workspace when any Azure Storage which is missing this diagnostic settings is created or updated. |
| Version             |  |
| Effect              | [parameters('effect')] |

#### 🧮 ~ Parameters
| Name | Description | Default Value | Allowed Values |
| ---- | ----------- | ------------- | -------------- |
| effect | Enable or disable the execution of the policy | DeployIfNotExists | AuditIfNotExists DeployIfNotExists Disabled |
| profileName | The diagnostic settings profile name | setbypolicy_Diagnostics |  |
| workspaceId | Select Log Analytics workspace from dropdown list. If this workspace is outside of the scope of the assignment you must manually grant 'Log Analytics Contributor' permissions (or similar) to the policy assignment's principal ID. |  |  |
| storageAccountId | The Storage Account Resource Id to send activity logs |  |  |
| eventHubAuthorizationRuleId | The Event Hub authorization rule Id for Azure Diagnostics. The authorization rule needs to be at Event Hub namespace level. e.g. /subscriptions/{subscription Id}/resourceGroups/{resource group}/providers/Microsoft.EventHub/namespaces/{Event Hub namespace}/authorizationrules/{authorization rule} |  |  |
| eventHubName | The EventHub name to stream activity logs to |  |  |
| metricsEnabled | Whether to enable metrics stream to the Log Analytics workspace - True or False | False | True False |
| logsEnabled | Enable Logs - True or False | True | True False |

<br>

<br>

### 📜 [deploy_subscription_diagnostic_setting](./Monitoring/deploy_subscription_diagnostic_setting.json)
| Title | Description |
| ----- | ----------- |
| Name                | deploy_subscription_diagnostic_setting |
| DisplayName         | Deploy Diagnostic Settings for Subscriptions to a Log Analytics workspace |
| Description         | Deploys the diagnostic settings for Subscriptions to stream to a regional Log Analytics workspace when any Subscription which is missing this diagnostic settings is created or updated. |
| Version             |  |
| Effect              | [parameters('effect')] |

#### 🧮 ~ Parameters
| Name | Description | Default Value | Allowed Values |
| ---- | ----------- | ------------- | -------------- |
| effect | Enable or disable the execution of the policy | DeployIfNotExists | DeployIfNotExists AuditIfNotExists Disabled |
| profileName | The diagnostic settings profile name | setbypolicy_Diagnostics |  |
| workspaceId | Select Log Analytics workspace from dropdown list. If this workspace is outside of the scope of the assignment you must manually grant 'Log Analytics Contributor' permissions (or similar) to the policy assignment's principal ID. |  |  |
| storageAccountId | The Storage Account Resource Id to send activity logs |  |  |
| eventHubAuthorizationRuleId | The Event Hub authorization rule Id for Azure Diagnostics. The authorization rule needs to be at Event Hub namespace level. e.g. /subscriptions/{subscription Id}/resourceGroups/{resource group}/providers/Microsoft.EventHub/namespaces/{Event Hub namespace}/authorizationrules/{authorization rule} |  |  |
| eventHubName | The EventHub name to stream activity logs to |  |  |
| logsEnabled | Enable Logs - True or False | True | True False |

<br>

<br>

### 📜 [deploy_virtual_machine_diagnostic_setting](./Monitoring/deploy_virtual_machine_diagnostic_setting.json)
| Title | Description |
| ----- | ----------- |
| Name                | deploy_virtual_machine_diagnostic_setting |
| DisplayName         | Deploy Diagnostic Settings for Virtual Machines to a Log Analytics workspace |
| Description         | Deploys the diagnostic settings for Virtual Machines to stream to a regional Log Analytics workspace when any Virtual Machine which is missing this diagnostic settings is created or updated. |
| Version             |  |
| Effect              | [parameters('effect')] |

#### 🧮 ~ Parameters
| Name | Description | Default Value | Allowed Values |
| ---- | ----------- | ------------- | -------------- |
| effect | Enable or disable the execution of the policy | DeployIfNotExists | AuditIfNotExists DeployIfNotExists Disabled |
| profileName | The diagnostic settings profile name | setbypolicy_Diagnostics |  |
| workspaceId | Select Log Analytics workspace from dropdown list. If this workspace is outside of the scope of the assignment you must manually grant 'Log Analytics Contributor' permissions (or similar) to the policy assignment's principal ID. |  |  |
| storageAccountId | The Storage Account Resource Id to send activity logs |  |  |
| eventHubAuthorizationRuleId | The Event Hub authorization rule Id for Azure Diagnostics. The authorization rule needs to be at Event Hub namespace level. e.g. /subscriptions/{subscription Id}/resourceGroups/{resource group}/providers/Microsoft.EventHub/namespaces/{Event Hub namespace}/authorizationrules/{authorization rule} |  |  |
| eventHubName | The EventHub name to stream activity logs to |  |  |
| metricsEnabled | Whether to enable metrics stream to the Log Analytics workspace - True or False | False | True False |
| logsEnabled | Whether to enable logs stream to the Log Analytics workspace - True or False | True | True False |

<br>

<br>

### 📜 [deploy_vnet_diagnostic_setting](./Monitoring/deploy_vnet_diagnostic_setting.json)
| Title | Description |
| ----- | ----------- |
| Name                | deploy_vnet_diagnostic_setting |
| DisplayName         | Deploy Diagnostic Settings for Virtual Networks to a Log Analytics workspace |
| Description         | Deploys the diagnostic settings for Virtual Networks to stream to a regional Log Analytics workspace when any Virtual Network which is missing this diagnostic settings is created or updated. |
| Version             |  |
| Effect              | [parameters('effect')] |

#### 🧮 ~ Parameters
| Name | Description | Default Value | Allowed Values |
| ---- | ----------- | ------------- | -------------- |
| effect | Enable or disable the execution of the policy | DeployIfNotExists | AuditIfNotExists DeployIfNotExists Disabled |
| profileName | The diagnostic settings profile name | setbypolicy_Diagnostics |  |
| workspaceId | Select Log Analytics workspace from dropdown list. If this workspace is outside of the scope of the assignment you must manually grant 'Log Analytics Contributor' permissions (or similar) to the policy assignment's principal ID. |  |  |
| storageAccountId | The Storage Account Resource Id to send activity logs |  |  |
| eventHubAuthorizationRuleId | The Event Hub authorization rule Id for Azure Diagnostics. The authorization rule needs to be at Event Hub namespace level. e.g. /subscriptions/{subscription Id}/resourceGroups/{resource group}/providers/Microsoft.EventHub/namespaces/{Event Hub namespace}/authorizationrules/{authorization rule} |  |  |
| eventHubName | The EventHub name to stream activity logs to |  |  |
| metricsEnabled | Whether to enable metrics stream to the Log Analytics workspace - True or False | False | True False |
| logsEnabled | Whether to enable logs stream to the Log Analytics workspace - True or False | True | True False |

<br>

<br>

### 📜 [deploy_vnet_gateway_diagnostic_setting](./Monitoring/deploy_vnet_gateway_diagnostic_setting.json)
| Title | Description |
| ----- | ----------- |
| Name                | deploy_vnet_gateway_diagnostic_setting |
| DisplayName         | Deploy Diagnostic Settings for Virtual Network Gateways to a Log Analytics workspace |
| Description         | Deploys the diagnostic settings for Virtual Network Gateways to stream to a regional Log Analytics workspace when any Virtual Network Gateway which is missing this diagnostic settings is created or updated. |
| Version             |  |
| Effect              | [parameters('effect')] |

#### 🧮 ~ Parameters
| Name | Description | Default Value | Allowed Values |
| ---- | ----------- | ------------- | -------------- |
| effect | Enable or disable the execution of the policy | DeployIfNotExists | AuditIfNotExists DeployIfNotExists Disabled |
| profileName | The diagnostic settings profile name | setbypolicy_Diagnostics |  |
| workspaceId | Select Log Analytics workspace from dropdown list. If this workspace is outside of the scope of the assignment you must manually grant 'Log Analytics Contributor' permissions (or similar) to the policy assignment's principal ID. |  |  |
| storageAccountId | The Storage Account Resource Id to send activity logs |  |  |
| eventHubAuthorizationRuleId | The Event Hub authorization rule Id for Azure Diagnostics. The authorization rule needs to be at Event Hub namespace level. e.g. /subscriptions/{subscription Id}/resourceGroups/{resource group}/providers/Microsoft.EventHub/namespaces/{Event Hub namespace}/authorizationrules/{authorization rule} |  |  |
| eventHubName | The EventHub name to stream activity logs to |  |  |
| metricsEnabled | Whether to enable metrics stream to the Log Analytics workspace - True or False | False | True False |
| logsEnabled | Whether to enable logs stream to the Log Analytics workspace - True or False | True | True False |

<br>

<br>

### 📜 [deploy_keyvault_diagnostic_setting](./Monitoring/deploy_keyvault_diagnostic_setting.json)
| Title | Description |
| ----- | ----------- |
| Name                | deploy_keyvault_diagnostic_setting |
| DisplayName         | Deploy Diagnostic Settings for KeyVaults to a Log Analytics workspace |
| Description         | Deploys the diagnostic settings for KeyVaults to stream to a regional Log Analytics workspace when any KeyVault which is missing this diagnostic settings is created or updated. |
| Version             |  |
| Effect              | [parameters('effect')] |

#### 🧮 ~ Parameters
| Name | Description | Default Value | Allowed Values |
| ---- | ----------- | ------------- | -------------- |
| effect | Enable or disable the execution of the policy | DeployIfNotExists | AuditIfNotExists DeployIfNotExists Disabled |
| profileName | The diagnostic settings profile name | setbypolicy_Diagnostics |  |
| workspaceId | Select Log Analytics workspace from dropdown list. If this workspace is outside of the scope of the assignment you must manually grant 'Log Analytics Contributor' permissions (or similar) to the policy assignment's principal ID. |  |  |
| storageAccountId | The Storage Account Resource Id to send activity logs |  |  |
| eventHubAuthorizationRuleId | The Event Hub authorization rule Id for Azure Diagnostics. The authorization rule needs to be at Event Hub namespace level. e.g. /subscriptions/{subscription Id}/resourceGroups/{resource group}/providers/Microsoft.EventHub/namespaces/{Event Hub namespace}/authorizationrules/{authorization rule} |  |  |
| eventHubName | The EventHub name to stream activity logs to |  |  |
| metricsEnabled | Whether to enable metrics stream to the Log Analytics workspace - True or False | False | True False |
| logsEnabled | Whether to enable logs stream to the Log Analytics workspace - True or False | True | True False |

<br>

<br>

### 📜 [deploy_firewall_diagnostic_setting](./Monitoring/deploy_firewall_diagnostic_setting.json)
| Title | Description |
| ----- | ----------- |
| Name                | deploy_firewall_diagnostic_setting |
| DisplayName         | Deploy Diagnostic Settings for Firewalls to a Log Analytics workspace |
| Description         | Deploys the diagnostic settings for Firewalls to stream to a regional Log Analytics workspace when any Firewall which is missing this diagnostic settings is created or updated. |
| Version             |  |
| Effect              | [parameters('effect')] |

#### 🧮 ~ Parameters
| Name | Description | Default Value | Allowed Values |
| ---- | ----------- | ------------- | -------------- |
| effect | Enable or disable the execution of the policy | DeployIfNotExists | AuditIfNotExists DeployIfNotExists Disabled |
| profileName | The diagnostic settings profile name | setbypolicy_Diagnostics |  |
| workspaceId | Select Log Analytics workspace from dropdown list. If this workspace is outside of the scope of the assignment you must manually grant 'Log Analytics Contributor' permissions (or similar) to the policy assignment's principal ID. |  |  |
| storageAccountId | The Storage Account Resource Id to send activity logs |  |  |
| eventHubAuthorizationRuleId | The Event Hub authorization rule Id for Azure Diagnostics. The authorization rule needs to be at Event Hub namespace level. e.g. /subscriptions/{subscription Id}/resourceGroups/{resource group}/providers/Microsoft.EventHub/namespaces/{Event Hub namespace}/authorizationrules/{authorization rule} |  |  |
| eventHubName | The EventHub name to stream activity logs to |  |  |
| metricsEnabled | Whether to enable metrics stream to the Log Analytics workspace - True or False | False | True False |
| logsEnabled | Whether to enable logs stream to the Log Analytics workspace - True or False | True | True False |

<br>

<br>

### 📜 [deploy_expressroute_connection_diagnostic_setting](./Monitoring/deploy_expressroute_connection_diagnostic_setting.json)
| Title | Description |
| ----- | ----------- |
| Name                | deploy_expressroute_connection_diagnostic_setting |
| DisplayName         | Deploy Diagnostic Settings for ExpressRoute Connections to a Log Analytics workspace |
| Description         | Deploys the diagnostic settings for ExpressRoute Connections to stream to a regional Log Analytics workspace when any ExpressRoute Connection which is missing this diagnostic settings is created or updated. |
| Version             |  |
| Effect              | [parameters('effect')] |

#### 🧮 ~ Parameters
| Name | Description | Default Value | Allowed Values |
| ---- | ----------- | ------------- | -------------- |
| effect | Enable or disable the execution of the policy | DeployIfNotExists | AuditIfNotExists DeployIfNotExists Disabled |
| profileName | The diagnostic settings profile name | setbypolicy_Diagnostics |  |
| workspaceId | Select Log Analytics workspace from dropdown list. If this workspace is outside of the scope of the assignment you must manually grant 'Log Analytics Contributor' permissions (or similar) to the policy assignment's principal ID. |  |  |
| storageAccountId | The Storage Account Resource Id to send activity logs |  |  |
| eventHubAuthorizationRuleId | The Event Hub authorization rule Id for Azure Diagnostics. The authorization rule needs to be at Event Hub namespace level. e.g. /subscriptions/{subscription Id}/resourceGroups/{resource group}/providers/Microsoft.EventHub/namespaces/{Event Hub namespace}/authorizationrules/{authorization rule} |  |  |
| eventHubName | The EventHub name to stream activity logs to |  |  |
| metricsEnabled | Enable Metrics - True or False | True | True False |
| logsEnabled | Enable Logs - True or False | True | True False |

<br>

<br>

### 📜 [deploy_expressroute_diagnostic_setting](./Monitoring/deploy_expressroute_diagnostic_setting.json)
| Title | Description |
| ----- | ----------- |
| Name                | deploy_expressroute_diagnostic_setting |
| DisplayName         | Deploy Diagnostic Settings for ExpressRoutes to a Log Analytics workspace |
| Description         | Deploys the diagnostic settings for ExpressRoutes to stream to a regional Log Analytics workspace when any ExpressRoute which is missing this diagnostic settings is created or updated. |
| Version             |  |
| Effect              | [parameters('effect')] |

#### 🧮 ~ Parameters
| Name | Description | Default Value | Allowed Values |
| ---- | ----------- | ------------- | -------------- |
| effect | Enable or disable the execution of the policy | DeployIfNotExists | AuditIfNotExists DeployIfNotExists Disabled |
| profileName | The diagnostic settings profile name | setbypolicy_Diagnostics |  |
| workspaceId | Select Log Analytics workspace from dropdown list. If this workspace is outside of the scope of the assignment you must manually grant 'Log Analytics Contributor' permissions (or similar) to the policy assignment's principal ID. |  |  |
| storageAccountId | The Storage Account Resource Id to send activity logs |  |  |
| eventHubAuthorizationRuleId | The Event Hub authorization rule Id for Azure Diagnostics. The authorization rule needs to be at Event Hub namespace level. e.g. /subscriptions/{subscription Id}/resourceGroups/{resource group}/providers/Microsoft.EventHub/namespaces/{Event Hub namespace}/authorizationrules/{authorization rule} |  |  |
| eventHubName | The EventHub name to stream activity logs to |  |  |
| metricsEnabled | Enable Metrics - True or False | True | True False |
| logsEnabled | Enable Logs - True or False | True | True False |

<br>

<br>

### 📜 [audit_log_analytics_workspace_retention](./Monitoring/audit_log_analytics_workspace_retention.json)
| Title | Description |
| ----- | ----------- |
| Name                | audit_log_analytics_workspace_retention |
| DisplayName         |  |
| Description         |  |
| Version             |  |
| Effect              | [parameters('effect')] |

#### 🧮 ~ Parameters
| Name | Description | Default Value | Allowed Values |
| ---- | ----------- | ------------- | -------------- |
| effect | Enable or disable the execution of the policy | AuditIfNotExists | AuditIfNotExists Disabled |
| workspaceRetentionDays | Log Analytics Workspace should be retained for the specified amount of days. Defaults to 15 months | 456 |  |

<br>

<br>

### 📜 [audit_subscription_diagnostic_setting_should_exist](./Monitoring/audit_subscription_diagnostic_setting_should_exist.json)
| Title | Description |
| ----- | ----------- |
| Name                | audit_subscription_diagnostic_setting_should_exist |
| DisplayName         |  |
| Description         |  |
| Version             |  |
| Effect              | [parameters('effect')] |

#### 🧮 ~ Parameters
| Name | Description | Default Value | Allowed Values |
| ---- | ----------- | ------------- | -------------- |
| effect | Enable or disable the execution of the policy | AuditIfNotExists | AuditIfNotExists Disabled |

<br>

<br>

### 📜 [deploy_application_gateway_diagnostic_setting](./Monitoring/deploy_application_gateway_diagnostic_setting.json)
| Title | Description |
| ----- | ----------- |
| Name                | deploy_application_gateway_diagnostic_setting |
| DisplayName         | Deploy Diagnostic Settings for Application Gateways to a Log Analytics workspace |
| Description         | Deploys the diagnostic settings for Application Gateways to stream to a regional Log Analytics workspace when any Application Gateway which is missing this diagnostic settings is created or updated. |
| Version             |  |
| Effect              | [parameters('effect')] |

#### 🧮 ~ Parameters
| Name | Description | Default Value | Allowed Values |
| ---- | ----------- | ------------- | -------------- |
| effect | Enable or disable the execution of the policy | DeployIfNotExists | AuditIfNotExists DeployIfNotExists Disabled |
| profileName | The diagnostic settings profile name | setbypolicy_Diagnostics |  |
| workspaceId | Select Log Analytics workspace from dropdown list. If this workspace is outside of the scope of the assignment you must manually grant 'Log Analytics Contributor' permissions (or similar) to the policy assignment's principal ID. |  |  |
| storageAccountId | The Storage Account Resource Id to send activity logs |  |  |
| eventHubAuthorizationRuleId | The Event Hub authorization rule Id for Azure Diagnostics. The authorization rule needs to be at Event Hub namespace level. e.g. /subscriptions/{subscription Id}/resourceGroups/{resource group}/providers/Microsoft.EventHub/namespaces/{Event Hub namespace}/authorizationrules/{authorization rule} |  |  |
| eventHubName | The EventHub name to stream activity logs to |  |  |
| metricsEnabled | Whether to enable metrics stream to the Log Analytics workspace - True or False | False | True False |
| logsEnabled | Whether to enable logs stream to the Log Analytics workspace - True or False | True | True False |

<br>

<br>

### 📜 [deploy_eventhub_diagnostic_setting](./Monitoring/deploy_eventhub_diagnostic_setting.json)
| Title | Description |
| ----- | ----------- |
| Name                | deploy_eventhub_diagnostic_setting |
| DisplayName         | Deploy Diagnostic Settings for Event Hubs to a Log Analytics workspace |
| Description         | Deploys the diagnostic settings for Event Hubs to stream to a regional Log Analytics workspace when any Event Hub which is missing this diagnostic settings is created or updated. |
| Version             |  |
| Effect              | [parameters('effect')] |

#### 🧮 ~ Parameters
| Name | Description | Default Value | Allowed Values |
| ---- | ----------- | ------------- | -------------- |
| effect | Enable or disable the execution of the policy | DeployIfNotExists | AuditIfNotExists DeployIfNotExists Disabled |
| profileName | The diagnostic settings profile name | setbypolicy_Diagnostics |  |
| workspaceId | Select Log Analytics workspace from dropdown list. If this workspace is outside of the scope of the assignment you must manually grant 'Log Analytics Contributor' permissions (or similar) to the policy assignment's principal ID. |  |  |
| storageAccountId | The Storage Account Resource Id to send activity logs |  |  |
| eventHubAuthorizationRuleId | The Event Hub authorization rule Id for Azure Diagnostics. The authorization rule needs to be at Event Hub namespace level. e.g. /subscriptions/{subscription Id}/resourceGroups/{resource group}/providers/Microsoft.EventHub/namespaces/{Event Hub namespace}/authorizationrules/{authorization rule} |  |  |
| eventHubName | The EventHub name to stream activity logs to |  |  |
| metricsEnabled | Whether to enable metrics stream to the Log Analytics workspace - True or False | False | True False |
| logsEnabled | Whether to enable logs stream to the Log Analytics workspace - True or False | True | True False |

<br>

<br>

---

## Network

### 📜 [deny_nic_public_ip](./Network/deny_nic_public_ip.json)
| Title | Description |
| ----- | ----------- |
| Name                | deny_nic_public_ip |
| DisplayName         |  |
| Description         |  |
| Version             |  |
| Effect              | [parameters('effect')] |

#### 🧮 ~ Parameters
| Name | Description | Default Value | Allowed Values |
| ---- | ----------- | ------------- | -------------- |
| effect | The effect determines what happens when the policy rule is evaluated to match | Deny | Audit Deny Disabled |

<br>

<br>

---

## Security Center

### 📜 [auto_provision_log_analytics_agent_custom_workspace](./Security%20Center/auto_provision_log_analytics_agent_custom_workspace.json)
| Title | Description |
| ----- | ----------- |
| Name                | auto_provision_log_analytics_agent_custom_workspace |
| DisplayName         | Auto Provision Subscriptions to Log Analytics Custom to Workspace |
| Description         | Enable Security Center's auto provisioning of the Log Analytics agent on your subscriptions with custom workspace |
| Version             |  |
| Effect              | [parameters('effect')] |

#### 🧮 ~ Parameters
| Name | Description | Default Value | Allowed Values |
| ---- | ----------- | ------------- | -------------- |
| effect | Enable or disable the execution of the policy | DeployIfNotExists | DeployIfNotExists AuditIfNotExists Disabled |
| workspaceId | Auto provision the Log Analytics agent on your subscriptions to monitor and collect security data using a custom workspace. |  |  |

<br>

<br>

### 📜 [auto_set_contact_details](./Security%20Center/auto_set_contact_details.json)
| Title | Description |
| ----- | ----------- |
| Name                | auto_set_contact_details |
| DisplayName         | Set Security Center contact email address and phone number on Subscriptions |
| Description         | Automatically set the security contact email address and phone number should they be blank on the subscription |
| Version             |  |
| Effect              | [parameters('effect')] |

#### 🧮 ~ Parameters
| Name | Description | Default Value | Allowed Values |
| ---- | ----------- | ------------- | -------------- |
| effect | Enable or disable the execution of the policy | DeployIfNotExists | DeployIfNotExists AuditIfNotExists Disabled |
| securityContactsEmail | The email of the Security Center Contact. |  |  |
| securityContactsPhone | The phone number of the Security Center Contact. |  |  |

<br>

<br>

### 📜 [enable_vulnerability_vm_assessments](./Security%20Center/enable_vulnerability_vm_assessments.json)
| Title | Description |
| ----- | ----------- |
| Name                | enable_vulnerability_vm_assessments |
| DisplayName         | Enable Security Center VM Vulnerability Assessments |
| Description         | Enable Security Center VM Vulnerability Assessments |
| Version             |  |
| Effect              | [parameters('effect')] |

#### 🧮 ~ Parameters
| Name | Description | Default Value | Allowed Values |
| ---- | ----------- | ------------- | -------------- |
| effect | Enable or disable the execution of the policy | DeployIfNotExists | DeployIfNotExists AuditIfNotExists Disabled |

<br>

<br>

### 📜 [export_asc_alerts_and_recommendations_to_eventhub](./Security%20Center/export_asc_alerts_and_recommendations_to_eventhub.json)
| Title | Description |
| ----- | ----------- |
| Name                | export_asc_alerts_and_recommendations_to_eventhub |
| DisplayName         | Export ASC alerts and recommendations to eventhub |
| Description         | Enable Export to Event Hub for Azure Security Center alerts and recommendations |
| Version             |  |
| Effect              | [parameters('effect')] |

#### 🧮 ~ Parameters
| Name | Description | Default Value | Allowed Values |
| ---- | ----------- | ------------- | -------------- |
| effect | Enable or disable the execution of the policy | DeployIfNotExists | DeployIfNotExists AuditIfNotExists Disabled |
| resourceGroupName | The resource group name where the export to Event Hub configuration is created. If you enter a name for a resource group that doesn't exist, it'll be created in the subscription. Note that each resource group can only have one export to Event Hub configured. | policy-export-asc-alerts |  |
| resourceGroupLocation | The location where the resource group and the export to Event Hub configuration are created. | uksouth | uksouth ukwest |
| exportedDataTypes | The data types to be exported. Example: Security recommendations;Security alerts;Secure scores;Secure score controls; | Security recommendations Security alerts Overall secure score Secure score controls | Security recommendations Security alerts Overall secure score Secure score controls |
| recommendationNames | Applicable only for export of security recommendations. To export all recommendations, leave this empty. To export specific recommendations, enter a list of recommendation IDs separated by semicolons (';'). Recommendation IDs are available through the Assessments API (https://docs.microsoft.com/rest/api/securitycenter/assessments), or Azure Resource Graph Explorer (https://portal.azure.com/#blade/HubsExtension/ArgQueryBlade), choose securityresources and microsoft.security/assessments. |  |  |
| recommendationSeverities | Applicable only for export of security recommendations. Determines recommendation severities. Example: High;Medium;Low; | High Medium Low | High Medium Low |
| isSecurityFindingsEnabled | Security findings are results from vulnerability assessment solutions, and can be thought of as 'sub' recommendations grouped into a 'parent' recommendation. | True | True False |
| secureScoreControlsNames | Applicable only for export of secure score controls. To export all secure score controls, leave this empty. To export specific secure score controls, enter a list of secure score controls IDs separated by semicolons (';'). Secure score controls IDs are available through the Secure score controls API (https://docs.microsoft.com/rest/api/securitycenter/securescorecontrols), or Azure Resource Graph Explorer (https://portal.azure.com/#blade/HubsExtension/ArgQueryBlade), choose securityresources and microsoft.security/securescores/securescorecontrols. |  |  |
| alertSeverities | Applicable only for export of security alerts. Determines alert severities. Example: High;Medium;Low; | High Medium Low | High Medium Low |
| eventHubDetails | The Event Hub details of where the data should be exported to: Subscription, Event Hub Namespace, Event Hub, and Authorizations rules with 'Send' claim. If you do not already have an event hub, visit Event Hubs to create one (https://portal.azure.com/#blade/HubsExtension/BrowseResource/resourceType/Microsoft.EventHub%2Fnamespaces). |  |  |

<br>

<br>

### 📜 [export_asc_alerts_and_recommendations_to_log_analytics](./Security%20Center/export_asc_alerts_and_recommendations_to_log_analytics.json)
| Title | Description |
| ----- | ----------- |
| Name                | export_asc_alerts_and_recommendations_to_log_analytics |
| DisplayName         | Export ASC alerts and recommendations to Log Analytics |
| Description         | Enable Export to Log Analytics Workspace for Azure Security Center alerts and recommendations |
| Version             |  |
| Effect              | [parameters('effect')] |

#### 🧮 ~ Parameters
| Name | Description | Default Value | Allowed Values |
| ---- | ----------- | ------------- | -------------- |
| effect | Enable or disable the execution of the policy | DeployIfNotExists | DeployIfNotExists AuditIfNotExists Disabled |
| resourceGroupName | The resource group name where the export to Log Analytics configuration is created. If you enter a name for a resource group that doesn't exist, it'll be created in the subscription. Note that each resource group can only have one export to Log Analytics configured. | policy-export-asc-alerts |  |
| resourceGroupLocation | The location where the resource group and the export to Log Analytics configuration are created. | uksouth | uksouth ukwest |
| exportedDataTypes | The data types to be exported. Example: Security recommendations;Security alerts;Secure scores;Secure score controls; | Security recommendations Security alerts Overall secure score Secure score controls | Security recommendations Security alerts Overall secure score Secure score controls |
| recommendationNames | Applicable only for export of security recommendations. To export all recommendations, leave this empty. To export specific recommendations, enter a list of recommendation IDs separated by semicolons (';'). Recommendation IDs are available through the Assessments API (https://docs.microsoft.com/rest/api/securitycenter/assessments), or Azure Resource Graph Explorer (https://portal.azure.com/#blade/HubsExtension/ArgQueryBlade), choose securityresources and microsoft.security/assessments. |  |  |
| recommendationSeverities | Applicable only for export of security recommendations. Determines recommendation severities. Example: High;Medium;Low; | High Medium Low | High Medium Low |
| isSecurityFindingsEnabled | Security findings are results from vulnerability assessment solutions, and can be thought of as 'sub' recommendations grouped into a 'parent' recommendation. | True | True False |
| secureScoreControlsNames | Applicable only for export of secure score controls. To export all secure score controls, leave this empty. To export specific secure score controls, enter a list of secure score controls IDs separated by semicolons (';'). Secure score controls IDs are available through the Secure score controls API (https://docs.microsoft.com/rest/api/securitycenter/securescorecontrols), or Azure Resource Graph Explorer (https://portal.azure.com/#blade/HubsExtension/ArgQueryBlade), choose securityresources and microsoft.security/securescores/securescorecontrols. |  |  |
| alertSeverities | Applicable only for export of security alerts. Determines alert severities. Example: High;Medium;Low; | High Medium Low | High Medium Low |
| workspaceId | Auto provision the Log Analytics agent on your subscriptions to monitor and collect security data using a custom workspace. |  |  |

<br>

<br>

### 📜 [auto_enroll_subscriptions](./Security%20Center/auto_enroll_subscriptions.json)
| Title | Description |
| ----- | ----------- |
| Name                | auto_enroll_subscriptions |
| DisplayName         | Enroll Subscriptions to Azure Security Center |
| Description         | Enroll Subscriptions to Azure Security Center Standard Pricing Tier, Note: the new Containers Plan will be replacing Container Registries and Kubernetes |
| Version             |  |
| Effect              | [parameters('effect')] |

#### 🧮 ~ Parameters
| Name | Description | Default Value | Allowed Values |
| ---- | ----------- | ------------- | -------------- |
| effect | Enable or disable the execution of the policy | DeployIfNotExists | DeployIfNotExists AuditIfNotExists Disabled |
| pricingTier | ASC Pricing Tier | Standard | Free Standard |

<br>

<br>

---

## Storage

### 📜 [storage_enforce_https](./Storage/storage_enforce_https.json)
| Title | Description |
| ----- | ----------- |
| Name                | storage_enforce_https |
| DisplayName         |  |
| Description         |  |
| Version             |  |
| Effect              | [parameters('effect')] |

#### 🧮 ~ Parameters
| Name | Description | Default Value | Allowed Values |
| ---- | ----------- | ------------- | -------------- |
| effect | The effect determines what happens when the policy rule is evaluated to match | Deny | Audit Deny Disabled |

<br>

<br>

### 📜 [storage_enforce_minimum_tls1_2](./Storage/storage_enforce_minimum_tls1_2.json)
| Title | Description |
| ----- | ----------- |
| Name                | storage_enforce_minimum_tls1_2 |
| DisplayName         |  |
| Description         |  |
| Version             |  |
| Effect              | [parameters('effect')] |

#### 🧮 ~ Parameters
| Name | Description | Default Value | Allowed Values |
| ---- | ----------- | ------------- | -------------- |
| effect | The effect determines what happens when the policy rule is evaluated to match | Deny | Audit Deny Disabled |

<br>

<br>

---

## Tags

### 📜 [add_replace_resource_group_tag_key_modify](./Tags/add_replace_resource_group_tag_key_modify.json)
| Title | Description |
| ----- | ----------- |
| Name                | add_replace_resource_group_tag_key_modify |
| DisplayName         |  |
| Description         |  |
| Version             |  |
| Effect              | [parameters('effect')] |

#### 🧮 ~ Parameters
| Name | Description | Default Value | Allowed Values |
| ---- | ----------- | ------------- | -------------- |
| effect | The effect determines what happens when the policy rule is evaluated to match | Modify | Modify Disabled |

<br>

<br>

### 📜 [inherit_resource_group_tags_append](./Tags/inherit_resource_group_tags_append.json)
| Title | Description |
| ----- | ----------- |
| Name                | inherit_resource_group_tags_append |
| DisplayName         |  |
| Description         |  |
| Version             |  |
| Effect              | [parameters('effect')] |

#### 🧮 ~ Parameters
| Name | Description | Default Value | Allowed Values |
| ---- | ----------- | ------------- | -------------- |
| tagName | Name of the tag, such as 'environment' |  |  |
| effect | The effect determines what happens when the policy rule is evaluated to match | Append | Append Disabled |

<br>

<br>

### 📜 [inherit_resource_group_tags_modify](./Tags/inherit_resource_group_tags_modify.json)
| Title | Description |
| ----- | ----------- |
| Name                | inherit_resource_group_tags_modify |
| DisplayName         |  |
| Description         |  |
| Version             |  |
| Effect              | [parameters('effect')] |

#### 🧮 ~ Parameters
| Name | Description | Default Value | Allowed Values |
| ---- | ----------- | ------------- | -------------- |
| tagName | Name of the tag, such as 'environment' |  |  |
| effect | The effect determines what happens when the policy rule is evaluated to match | Modify | Modify Disabled |

<br>

<br>

### 📜 [require_resource_group_tags](./Tags/require_resource_group_tags.json)
| Title | Description |
| ----- | ----------- |
| Name                | require_resource_group_tags |
| DisplayName         |  |
| Description         |  |
| Version             |  |
| Effect              | [parameters('effect')] |

#### 🧮 ~ Parameters
| Name | Description | Default Value | Allowed Values |
| ---- | ----------- | ------------- | -------------- |
| tagName | Name of the tag, such as 'environment' |  |  |
| effect | The effect determines what happens when the policy rule is evaluated to match | Audit | Audit Deny Disabled |

<br>

<br>

---
