<#
.SYNOPSIS
    Converts Policies into JSON files from a terraform plan output
    Useful when migrating from an existing deployment
    terraform plan -out='tfplan'
.PARAMETER planFile
    The plan file name e.g. tfplan
#>

[CmdletBinding()]
Param(
    [string] [Parameter(Mandatory = $true)] $planFile = "tfplan"
)

# check dependancies
if ($PSVersionTable.PSVersion.Major -lt 7) { throw "Please use PowerShell >= 7.0" }

$VerbosePreference = 'Continue'
$ErrorActionPreference = 'SilentlyContinue'

Push-Location -Path $PSScriptRoot

# convert plan file to json
terraform show -json tfplan > tfplan.json

# create output directories
if (!(Get-ChildItem "./policies_output/.initiatives")) { New-Item -ItemType Directory -Name "./policies_output/.initiatives" }

# enable title case
$TextInfo = (Get-Culture).TextInfo

# import definitions
$definitions = (Get-Content "$planFile.json" | ConvertFrom-Json).planned_values.root_module.child_modules.resources

Write-Host "Creating $($definitions.Count) Policy Definitions from TF Plan..." -ForegroundColor Magenta

$definitions | Foreach-Object {
    $name = $_.values.name.Replace("-", "_").ToLower()
    $category = $TextInfo.ToTitleCase($name.Split("_")[1])

    try { $mode = $_.values.mode } catch { $mode = "All" }
    try { $parameters = $_.values.parameters } catch { $parameters = @{} }
    try { $policyRule = $_.values.policy_rule } catch { $policyRule = @{} }
    try {
        $metadata = $_.values.metadata | ConvertFrom-Json
        if (!($metadata.category)) {
            Add-Member -InputObject $metadata -MemberType NoteProperty -Name "category" -Value $category
        }
        if (!($metadata.version)) {
            Add-Member -InputObject $metadata -MemberType NoteProperty -Name "version" -Value "1.0.0"
        }
    }
    catch {
        $metadata = @{
            category = $category
            version  = "1.0.0"
        }
    }

    if ($_.type -eq "azurerm_policy_definition") {
        if (!(Get-ChildItem "./policies_output/$category")) { New-Item -ItemType Directory -Name "./policies_output/$category" }
        [ordered]@{
            type       = "Microsoft.Authorization/policyDefinitions"
            name       = $name
            properties = [ordered]@{
                displayName = $_.values.display_name
                description = $_.values.description
                mode        = $(if (!($mode)) { "All" } else { $mode })
                policyType  = "Custom"
                metadata    = $metadata
                parameters  = $(if (!($parameters)) { @{} } else { $parameters | ConvertFrom-Json })
                policyRule  = $(if (!($policyRule)) { @{} } else { $policyRule | ConvertFrom-Json })
            }
        } | ConvertTo-Json -Depth 100 | Out-File -FilePath "./policies_output/$category/$name.json" -Force
    }
    elseif ($_.type -eq "azurerm_policy_set_definition") {
        [ordered]@{
            type       = "Microsoft.Authorization/policySetDefinitions"
            name       = $name
            properties = [ordered]@{
                displayName             = $_.values.display_name
                description             = $_.values.description
                policyType              = "Custom"
                metadata                = $metadata
                parameters              = $(if (!($parameters)) { @{} } else { $parameters | ConvertFrom-Json })
                policy_definition_group = @()
                policyDefinitions       = @($_.values.policy_definition_reference)
            }
        } | ConvertTo-Json -Depth 100 | Out-File -FilePath "./policies_output/initiatives/$name.json" -Force
    }
}
Pop-Location
