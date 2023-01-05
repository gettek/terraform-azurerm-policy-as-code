<#
Create & Publish Azure Policy Guest Configuration packages from local PowerShell DSC Configs
MS Docs: How to create custom guest configuration package artifacts: https://learn.microsoft.com/en-us/azure/governance/policy/how-to/guest-configuration-create
Requires Azure PowerShell token, use -connectAzAccount flag to assume az cli token
#>

[CmdletBinding()]
Param(
    [switch][Parameter(Mandatory = $false)] $env:connectAzAccount, # use az cli token to authenticate to Azure PowerShell
    [switch][Parameter(Mandatory = $false)] $env:checkDependancies, # check and install required PowerShell modules
    [switch][Parameter(Mandatory = $false)] $env:housekeeping, # keep or remove local dsc packages
    [switch][Parameter(Mandatory = $false)] $env:createGuestConfigPackage, # generate the dsc package locally
    [switch][Parameter(Mandatory = $false)] $env:createGuestConfigPolicy, # generate the policy definition and publish dsc packages to storage
    [string][Parameter(Mandatory = $false)] $env:storageResourceGroupName, # storage account resource group name
    [string][Parameter(Mandatory = $false)] $env:storageAccountName, # storage account that will hold dsc packages
    [string][Parameter(Mandatory = $false)] $env:containerName, # storage container name that will hold dsc packages
    [string][Parameter(Mandatory = $false)] $env:publishGuestConfigPolicyMG # managment group to publish definitions
)

try {
    # Check dependancies required to build Custom Guest Configuration Packages
    if ($env:checkDependancies) {
        if ($PSVersionTable.PSVersion.Major -lt 7) { throw "Please use PowerShell >= 7.0" }

        # Include modules required by dsc configs
        $requiredModules = @(
            "Az.Accounts"
            "GuestConfiguration"
            "PSDscResources"
            "PSDesiredStateConfiguration"
            "AuditPolicyDsc"
            "SecurityPolicyDsc"
            "xWebAdministration"
            "nx"
        )
        Import-Module PowerShellGet
        $requiredModules | ForEach-Object {
            $latestVersion = (Find-Module -Name $_).Version.ToString()
            $installedVersion = Get-Module -ListAvailable -FullyQualifiedName $_

            if ($null -eq $installedVersion) {
                Write-Host "Installing Module $_..." -ForegroundColor Magenta
                Install-Module $_ -Force -confirm:$false -AllowClobber
            }
            elseif ($latestVersion -gt $installedVersion.Version.ToString()) {
                Write-Host "Updating Module $_ to the latest version $latestVersion"
                Update-Module -Name $_ -Confirm:$false -Force
            }
            Write-Host "Importing Module $_"
            Import-Module -Name $_
        }
    }

    if ($env:createGuestConfigPackage) {

        # Connect to Azure PowerShell using current az cli token context
        if ($env:connectAzAccount) {
            $token = (az account get-access-token | ConvertFrom-Json).accessToken
            $accountId = (az account show | ConvertFrom-Json)
            Connect-AzAccount -AccessToken $token -AccountId $accountId.user.name -Subscription $accountId.Id
        }

        # Set working directory to script path
        Push-Location -Path "$PSScriptRoot/dsc_examples"

        # Prepare output object
        $definitionList = [ordered]@{}

        foreach ($configName in (Get-ChildItem "*.ps1").BaseName) {

            # Compile the DSC configuration MOF file
            # ensure the configuration name is ALSO referenced at the end of the file itself
            & .\$configName

            # Create the Guest Configuration custom policy package
            $package = New-GuestConfigurationPackage `
                -Name $configName `
                -Configuration "./$configName/localhost.mof" `
                -Path "./" `
                -Force

            if ($env:createGuestConfigPolicy) {
                # Upload the package to azure storage blob
                $package = Publish-GuestConfigurationPackage `
                    -Path $package.Path `
                    -ResourceGroupName $env:storageResourceGroupName `
                    -StorageAccountName $env:storageAccountName `
                    -StorageContainerName $env:containerName `
                    -Force -Verbose

                # Create the Guest Configuration Policy definition
                $policy = New-GuestConfigurationPolicy `
                    -PolicyId "CGC_$configName" `
                    -ContentUri $package.ContentUri `
                    -DisplayName $configName `
                    -Description "VM Custom Guest Configuration: $configName" `
                    -Path "../../policies/Guest Configuration/CGC_$configName" `
                    -Version 1.0.0 `
                    -Mode 'ApplyAndAutoCorrect' `
                    -Platform $(if ($configName -like "nx*") { "Linux" } else { "Windows" })

                # Publish the Guest Configuration Policy to a Management Group
                if ($env:publishGuestConfigPolicyMG) {
                    $definition = Publish-GuestConfigurationPolicy -Path $policy.Path -ManagementGroupName $publishGuestConfigPolicyMG
                    $policyDefinitionId = $definition.PolicyDefinitionId
                }
                else { $policyDefinitionId = $null }

                # Populate output object
                $definitionList["CGC_$configName"] = @{
                    contentUri         = $package.ContentUri
                    policyDefinitionId = $policyDefinitionId
                }

                # Move and rename local policy to correct category path
                Move-Item ($policy.Path + "/DeployIfNotExists.json") -Destination ($policy.Path + ".json") -Force
                Start-Sleep -Seconds 1.5
                Remove-Item -Confirm:$false -Recurse -Force $policy.Path
            }

            # Clear or keep local DSC artifacts
            if ($env:housekeeping) {
                Start-Sleep -Seconds 1.5
                Remove-Item -Confirm:$false -Recurse -Force "./$configName"
            }
        }
        # Write output object
        $definitionList | ConvertTo-Json | Out-File -FilePath "$PSScriptRoot/definitionList.json" -Force

        # Return to original working directory
        Pop-Location

        # Clear Az PowerShell Context
        if ($env:connectAzAccount) {
            Start-Sleep -Seconds 1.5
            Clear-AzContext -Confirm:$false -Force
        }
    }
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
    Pop-Location
    if ($env:connectAzAccount) { Clear-AzContext -Confirm:$false -Force }
    Write-Error -Message $_.Exception -ErrorAction "stop"
}
