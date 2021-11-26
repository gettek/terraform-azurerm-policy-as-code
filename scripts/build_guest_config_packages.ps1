<#
Create & Publish Azure Policy Guest Configuration packages from local PowerShell DSC Configs
MS Docs: How to create custom guest configuration package artifacts: https://docs.microsoft.com/en-us/azure/governance/policy/how-to/guest-configuration-create
Requires Azure PowerShell token, assumes already authenticated with az cli
#>

[CmdletBinding()]
Param(
    [bool][Parameter(Mandatory = $false)] $createGuestConfigPackage = $true,
    [bool][Parameter(Mandatory = $false)] $createGuestConfigPolicy = $true,
    [string][Parameter(Mandatory = $false)] $publishGuestConfigPolicyMG,
    [string][Parameter(Mandatory = $false)] $storageResourceGroupName,
    [string][Parameter(Mandatory = $false)] $storageAccountName,
    [string][Parameter(Mandatory = $false)] $containerName,
    [switch][Parameter(Mandatory = $false)] $connectAzAccount,
    [switch][Parameter(Mandatory = $false)] $checkDependancies,
    [switch][Parameter(Mandatory = $false)] $housekeeping
)

$ErrorActionPreference = "Stop"
$VerbosePreference = "Continue"

# Set working directory to script path
Push-Location -Path "$PSScriptRoot/dsc_examples"

try {
    # Check dependancies required to build Custom Guest Configuration Packages
    if ($checkDependancies) {
        if ($PSVersionTable.PSVersion.Major -lt 7) { throw "Please use PowerShell >= 7.0" }

        # include modules required by dsc configs
        $requiredModules = @(
            "GuestConfiguration"
            "PSDscResources"
            "PSDesiredStateConfiguration"
            "AuditPolicyDsc"
            "SecurityPolicyDsc"
            "xWebAdministration"
            "nx"
        )
        $requiredModules | ForEach-Object {
            $latestVersion = (Find-Module -Name $_).Version.ToString()
            $installedVersion = Get-Module -ListAvailable -FullyQualifiedName $_

            if ($null -eq $installedVersion) {
                Write-Host "🔷 Installing Module $_..." -ForegroundColor Magenta
                Install-Module $_ -Force -confirm:$false -AllowClobber
            }
            elseif ($latestVersion -gt $installedVersion.Version.ToString()) {
                Write-Host "🔷 Updating Module $_ to the latest version $latestVersion"
                Update-Module -Name $_ -Confirm:$false -Force
            }
            Import-Module -Name $_
        }
    }

    # Connect to Azure PowerShell using current az cli token context
    if ($connectAzAccount) {
        $token = (az account get-access-token | ConvertFrom-Json).accessToken
        $accountId = (az account show | ConvertFrom-Json)
        Connect-AzAccount -AccessToken $token -AccountId $accountId.user.name -Subscription $accountId.Id
    }

    # retrieve dsc configs
    $configs = Get-ChildItem "*.ps1"
    $configs.Name | ForEach-Object {
        $configName = ($_ -replace ".ps1", "")

        & .\$_ # Compile the DSC configuration MOF file - ensure the configuration name is ALSO referenced at the end of the file itself for this line to work!

        # Create the Guest Configuration custom policy package
        if ($createGuestConfigPackage) {
            $package = New-GuestConfigurationPackage `
                -Name $configName `
                -Configuration "./$configName/localhost.mof" `
                -Path "./" `
                -Force `
                -Verbose
        }

        if ($createGuestConfigPolicy) {
            # Upload the package to azure storage blob
            $publish = Publish-GuestConfigurationPackage `
                -Path $package.Path `
                -ResourceGroupName $storageResourceGroupName `
                -StorageAccountName $storageAccountName `
                -StorageContainerName $containerName `
                -Force `
                -Verbose
            
            # Create the Guest Configuration Policy definition
            $policy = New-GuestConfigurationPolicy `
                -PolicyId "CGC_$configName" `
                -ContentUri $publish.ContentUri `
                -DisplayName $configName `
                -Description "VM Custom Guest Configuration: $configName" `
                -Path "../../policies/Guest Configuration/CGC_$configName" `
                -Version 1.0.0 `
                -Mode 'ApplyAndAutoCorrect' `
                -Platform $(if ($configName -like "nx*") { "Linux" } else { "Windows" }) `
                -Verbose
        }

        # Publish the Guest Configuration Policy to a Management Group
        if ($publishGuestConfigPolicyMG) {
            Publish-GuestConfigurationPolicy -Path $policy.Path -ManagementGroupName $publishGuestConfigPolicyMG
        }

        # Move and rename policy to correct category path
        Move-Item ($policy.Path + "/DeployIfNotExists.json") -Destination ($policy.Path + ".json") -Force
        Start-Sleep -Seconds 1.5
        Remove-Item -Confirm:$false -Recurse -Force $policy.Path
        
        # Clear or keep local DSC artifacts
        if ($housekeeping) {
            Start-Sleep -Seconds 1.5
            Remove-Item -Confirm:$false -Recurse -Force "./$configName"
        }
    }
    if ($connectAzAccount) { Clear-AzContext -Confirm:$false -Force }
}
catch {
    [System.Management.Automation.ErrorRecord]$e = $_
    $info = [PSCustomObject]@{
        Column    = $e.InvocationInfo.OffsetInLine
        Exception = $e.Exception.Message
        Line      = $e.InvocationInfo.ScriptLineNumber
        Reason    = $e.CategoryInfo.Reason
        Script    = $e.InvocationInfo.ScriptName
        Target    = $e.CategoryInfo.TargetName
    }
    $info
    if ($connectAzAccount) { Clear-AzContext -Confirm:$false -Force }
    Pop-Location
    Write-Error -Message $_.Exception -ErrorAction "stop"
}
