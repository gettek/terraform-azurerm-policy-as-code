# PRECOMMIT TASKS
# Requires 'terraform-docs' (https://terraform-docs.io/)

[CmdletBinding()]
Param(
    [switch] [Parameter(Mandatory = $False)] $tf,
    [switch] [Parameter(Mandatory = $False)] $checksums,
    [switch] [Parameter(Mandatory = $False)] $library,
    [switch] [Parameter(Mandatory = $False)] $lint
)

$env:ARM_SKIP_CREDENTIALS_VALIDATION = 'true'
$env:ARM_SKIP_PROVIDER_REGISTRATION = 'true'

$docConfigs = Resolve-Path -Path "$PSScriptRoot/../.config"
$modules = Resolve-Path -Path "$PSScriptRoot/../modules"
$examples = Resolve-Path -Path "$PSScriptRoot/../"
$policies = Resolve-Path -Path "$PSScriptRoot/../policies"

# Modules
Push-Location $modules
(Get-ChildItem -Directory).BaseName | Foreach-Object {
    try {
        Push-Location -Path $_
        if ($tf) {
            Write-Host "🟪 Running TF Init on '$_'..." -ForegroundColor Magenta
            terraform init -backend=false -upgrade
            Write-Host "✅ Terraform fmt & validate '$_'..." -ForegroundColor Magenta
            terraform fmt
            terraform validate
        }
        Write-Host "📜 Generating '$_' Docs..." -ForegroundColor Magenta
        terraform-docs `
            -c "$docConfigs\terraform-docs.yml" . `
            --header-from "$docConfigs\templ-$_.md" `
            --hide modules `
            --output-mode replace | Out-Null
    }
    catch {
        Write-Host "🥵 Could not complete precommit tasks: $_" -ForegroundColor Red
    }
    finally {
        Pop-Location
    }
}

# Examples
Push-Location $examples
(Get-ChildItem -Directory -Path examples*).BaseName | Foreach-Object {
    try {
        Push-Location -Path $_
        if ($tf) {
            Write-Host "🟪 Running TF Init on '$_'..." -ForegroundColor Magenta
            terraform init -backend=false -upgrade
            if ($checksums) {
                Write-Host "🔢 Calculating Provider Checksums..." -ForegroundColor Magenta
                terraform providers lock -platform=windows_amd64 -platform=linux_amd64
            }
            Write-Host "✅ Terraform fmt & validate '$_'..." -ForegroundColor Magenta
            terraform fmt
            terraform validate
        }
        Write-Host "📜 Generating '$_' Docs..." -ForegroundColor Magenta
        terraform-docs `
            -c "$docConfigs\terraform-docs.yml" . `
            --header-from "$docConfigs\templ-$_.md" `
            --output-mode replace | Out-Null
    }
    catch {
        Write-Host "🥵 Could not complete precommit tasks: $_" -ForegroundColor Red
    }
    finally {
        Pop-Location
    }
}

# Return to original working directory
Pop-Location; Pop-Location


# Update custom definition library readme
if ($library) {
    Write-Host "📜 Generating Custom Library Docs..." -ForegroundColor Magenta
    & "$PSScriptRoot/markdown_generator.ps1"
}

if ($lint) {
    $categories = (Get-ChildItem -Directory $policies -Exclude 'Deprecated').name
    $noDefaultValues = @{}

    $categories.ForEach({
            Write-Host "Processing Policy Category $_..." -ForegroundColor Magenta

            $category = $_
            $fileName = $_.Replace(' ', '-').ToLower()
            $defs = (Get-ChildItem -File "$policies/$_" -Exclude 'README.md', '.gitkeep').FullName
            $defs.ForEach({
                    $policyName = $_.Split('\')[-1].Replace('.json', '')
                    $policyObject = (Get-Content $_ | ConvertFrom-Json -AsHashtable -Depth 200)
                    try {
                        $policyParameters = $policyObject.properties.parameters
                        $policyParameters.Keys | ForEach-Object {
                            $parameterName = $_
                            $value = $policyParameters.$_

                            if (!$value.Keys.Contains('defaultValue')) {
                                $noDefaultValues += @{
                                    "$category > ${policyName} > $parameterName" = $value.type
                                }
                            }
                        }
                    }
                    catch {
                        Write-Host "$policyName does not contain any params" -ForegroundColor Yellow
                    }
                })
        })

    if ($noDefaultValues.Count -gt 0) {
        Write-Host "❌ The definitions below are missing defaultValues:"
        $noDefaultValues | Sort-Object | Format-Table -AutoSize
    }
}
