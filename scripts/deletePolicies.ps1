# Used by GitHub Workflows to clean deployed resources quicker than tf destroy
# Preferred over terraform destroy as remediation tasks must be in a terminal provisioning state (Succeeded, Canceled, Failed) before they can be deleted.

Get-AzPolicyAssignment -Scope "/providers/Microsoft.Management/managementgroups/team_a" | Remove-AzPolicyAssignment -Verbose
Get-AzPolicyAssignment -Scope "/providers/Microsoft.Management/managementgroups/policy_dev" | Remove-AzPolicyAssignment -Verbose
Get-AzPolicySetDefinition -ManagementGroupName "policy_dev" -Custom | Remove-AzPolicySetDefinition -Force -Verbose
Get-AzPolicyDefinition -ManagementGroupName "policy_dev" -Custom | Remove-AzPolicyDefinition -Force -Verbose

# Remove policy exemption.tf deployment
Remove-AzDeployment -name "Onboard_subscription_to_ASC_Exemption"
