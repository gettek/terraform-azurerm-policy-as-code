<#
.SYNOPSIS
    Create & Publish Azure Policy Guest Configuration packages from local PowerShell DSC Configs
    Requires Azure PowerShell, use -connectAzAccount flag to assume az cli token
.DESCRIPTION
    Use this script to simplify machine config package build and publish with Terraform
    Paramters are set as Environment Variables '$env' as to work with the Terraform (null_resource) interpreter
    Running terraform apply with -parallelism=1 will prevent the GuestConfiguration module from encountering conflicts during package creation
.PARAMETER configFile
    DSC Config File Name
.PARAMETER connectAzAccount
    use Az CLI Token to authenticate to Azure PowerShell, Omit if already authenticated
.PARAMETER checkDependancies
    Check and install required PowerShell modules
.PARAMETER housekeeping
    Keep or remove local DSC package MOFs and Zips, these are uploaded to Azure Storage for Policy deployments to retrieve
.PARAMETER createGuestConfigPackage
    Generate the DSC package locally
.PARAMETER createGuestConfigPolicy
    Generate the policy definition and publish dsc packages to storage
.PARAMETER storageResourceGroupName
    Storage Account Resource Group name
.PARAMETER storageAccountName
    Storage Account that will hold DSC packages
.PARAMETER containerName
    Storage Container name that will hold DSC packages
.PARAMETER publishGuestConfigPolicyMG
    Managment Group Name to publish Policy Definitions
.NOTES
    Author: Sadik Tekin
    Automating CGC Package Deployment:
    https://github.com/gettek/terraform-azurerm-policy-as-code/tree/main/examples-machine-config
#>

[CmdletBinding()]
Param(
    [switch][Parameter(Mandatory = $false)] $env:configFile,
    [switch][Parameter(Mandatory = $false)] $env:connectAzAccount,
    [switch][Parameter(Mandatory = $false)] $env:checkDependancies,
    [switch][Parameter(Mandatory = $false)] $env:housekeeping,
    [switch][Parameter(Mandatory = $false)] $env:createGuestConfigPackage,
    [switch][Parameter(Mandatory = $false)] $env:createGuestConfigPolicy,
    [string][Parameter(Mandatory = $false)] $env:storageResourceGroupName,
    [string][Parameter(Mandatory = $false)] $env:storageAccountName,
    [string][Parameter(Mandatory = $false)] $env:containerName,
    [string][Parameter(Mandatory = $false)] $env:publishGuestConfigPolicyMG
)

# Check dependancies required to build Custom Machine Configuration Packages
if ($env:checkDependancies) {
    if ($PSVersionTable.PSVersion.Major -lt 7) { throw "Please use PowerShell >= 7.0" }
    Import-Module PowerShellGet
    # Include modules required by dsc configs
    @(
        'Az.Storage'
        'GuestConfiguration'
        'PSDscResources'
        'PSDesiredStateConfiguration'
        'AuditPolicyDsc'
        'SecurityPolicyDsc'
        'xWebAdministration'
        'nx'
    ).ForEach({
            try {
                Find-Module -Name $_ -Verbose | ForEach-Object {
                    $installedVersion = (Get-InstalledModule -Name $_.Name -ErrorAction SilentlyContinue).Version
                    if (!($installedVersion)) {
                        Write-Host '🟢 Installing New Module' $_.Name $_.Version -ForegroundColor Green
                    }
                    elseif ($installedVersion -lt $_.Version) {
                        Write-Host '🔷 Updating' $_.Name $installedVersion '->' $_.Version -ForegroundColor Blue
                    }
                    $command = @{
                        Name            = $_.Name
                        RequiredVersion = $_.Version
                        Scope           = 'AllUsers'
                        Force           = $true
                        AcceptLicense   = $true
                        Confirm         = $false
                        Verbose         = $true
                    }
                    Install-Module @command
                }
            }
            catch { Write-Host "🥵 Could not install module: $_" -ForegroundColor Red }
        })
}

if ($env:createGuestConfigPackage) {
    $startTime = Get-Date
    Start-Sleep -Seconds 1.5

    # Connect to Azure PowerShell using current az cli token context
    if ($env:connectAzAccount) {
        $conn = @{
            TenantId       = $env:ARM_TENANT_ID
            SubscriptionId = $env:ARM_SUBSCRIPTION_ID
            credential     = (New-Object System.Management.Automation.PSCredential ($env:ARM_CLIENT_ID, (ConvertTo-SecureString $env:ARM_CLIENT_SECRET -AsPlainText -Force)))
            WarningAction  = 'SilentlyContinue'
        }
        try {
            Connect-AzAccount @conn -ServicePrincipal -Confirm:$false | Out-Null
        }
        catch {
            Write-Host "🔑 Could not Authenticate to Azure: $_" -ForegroundColor Red
            Exit 1
        }
    }

    $configPath = (Get-ChildItem "$PSScriptRoot/dsc_examples/$env:configFile")
    $configName = $configPath.BaseName.Split('_')[-0]
    $configversion = $configPath.BaseName.Split('_')[-1]

    try {
        # Compile the DSC configuration MOF file
        # ensure the configuration name is ALSO referenced at the end of the file itself
        & $configPath.FullName | Out-Null

        # Create the Guest Configuration custom policy package
        $packageConfig = @{
            Name          = $configName
            Configuration = "$PSScriptRoot/$configName/localhost.mof"
            Path          = $PSScriptRoot
            Version       = $configversion
            Type          = 'AuditAndSet'
        }
        $package = New-GuestConfigurationPackage @packageConfig -Force
        Write-Host "🗃️ New GuestConfig Package Created: $configName v$configversion" -ForegroundColor Green
    }
    catch {
        Write-Host "🔴 Could not Create GuestConfig Package $configName v${configversion}: $_" -ForegroundColor Red
    }

    if ($env:createGuestConfigPolicy) {

        # Upload the package to azure storage blob
        try {
            $saKey = (Get-AzStorageAccountKey -ResourceGroupName $env:storageResourceGroupName -Name $env:storageAccountName).value[0]
            $context = New-AzStorageContext -ConnectionString "DefaultEndpointsProtocol=https;AccountName=$env:storageAccountName;AccountKey=$saKey;"
            $uploadPackage = Set-AzStorageBlobContent -Container $env:containerName -File $package.Path -Context $context -Force
            Write-Host "⬆️ Uploaded Package to Storage: $env:storageAccountName/$env:containerName/$configName.zip" -ForegroundColor DarkCyan
        }
        catch {
            Write-Host "🔴 Could not Uploaded Package to Storage: $_" -ForegroundColor Red
        }

        # Clear or keep local DSC artifacts
        if ($env:housekeeping) {
            Start-Sleep -Seconds 1.5
            Remove-Item -Confirm:$false -Recurse -Force $configName, "$configName.zip"
            Write-Host "🧹 Removed local redundant files: $configName.zip" -ForegroundColor Yellow
        }

        # Create ContentUri for policy deployments to pull from
        try {
            $sasRequest = @{
                StartTime  = $startTime
                ExpiryTime = $startTime.AddYears(1)
                Container  = $env:containerName
                Blob       = $uploadPackage.Name
                Permission = 'r'
                Context    = $context
            }
            $contentUri = New-AzStorageBlobSASToken @sasRequest -FullUri
        }
        catch {
            Write-Host "🔴 Could not generate SAS Token: $_" -ForegroundColor Red
        }

        # Create the Machine Configuration Policy definition
        try {
            $PolicyConfig = @{
                PolicyId      = New-Guid
                ContentUri    = $contentUri
                DisplayName   = "[CGC]: $configName v$configversion"
                Description   = "VM Custom Machine Config: $configName v$configversion"
                Path          = '../policies/Guest Configuration'
                Platform      = $(if ($configName -like 'nx*') { 'Linux' } else { 'Windows' })
                Mode          = 'ApplyAndAutoCorrect'
                PolicyVersion = $configversion
            }
            $policy = New-GuestConfigurationPolicy @PolicyConfig

            # Move local policy to correct library path
            $libraryPath = "../policies/Guest Configuration/${configName}_${configversion}.json"
            Move-Item -Path $policy.Path -Destination $libraryPath -Force -Confirm:$false
            Write-Host "✅ Policy Definition Created: $libraryPath" -ForegroundColor Yellow
            # Remove older versions
            (Get-ChildItem "../policies/Guest Configuration/${configName}_*.json").FullName | Where-Object { $_ -notlike "*$configversion*" } | Remove-Item -Force -Confirm:$false
        }
        catch {
            Write-Host "🔴 Could not create Policy Definition: $_" -ForegroundColor Red
        }

        # Publish the Machine Configuration Policy to a Management Group
        if ($env:publishGuestConfigPolicyMG) {
            try {
                $publishDefinition = New-AzPolicyDefinition -Name $configName -Policy $libraryPath -ManagementGroupName $env:publishGuestConfigPolicyMG
                Write-Host "📜 Policy Definition Published: $($publishDefinition.PolicyDefinitionId)" -ForegroundColor DarkCyan
            }
            catch {
                Write-Host "🔴 Could not Publish Policy Definition: $_" -ForegroundColor Red
            }
        }
    }

    # Clear Az PowerShell Context
    if ($env:connectAzAccount) {
        Start-Sleep -Seconds 1.5
        Clear-AzContext -Confirm:$false -Force
    }

    Write-Host "👍 Completed Build Machine Config Packages" -ForegroundColor Green
}
