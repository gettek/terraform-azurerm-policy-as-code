# PRECOMMIT TASKS
# Requires 'terraform-docs' (https://terraform-docs.io/)

[CmdletBinding()]
Param(
    [switch] [Parameter(Mandatory = $False)] $tf,
    [switch] [Parameter(Mandatory = $False)] $library
)

$docConfigs = Resolve-Path -Path "$PSScriptRoot/../.config"
$modules = Resolve-Path -Path "$PSScriptRoot/../modules"
$examples = Resolve-Path -Path "$PSScriptRoot/../"

# Modules
Push-Location $modules
(Get-ChildItem -Directory).BaseName | Foreach-Object {
    try {
        Push-Location -Path $_
        if ($tf) {
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
            terraform init -backend=false -upgrade
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
