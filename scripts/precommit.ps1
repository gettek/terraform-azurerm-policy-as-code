# PRECOMMIT TASKS

[CmdletBinding()]
Param(
    [switch] [Parameter(Mandatory = $False)] $tf,
    [switch] [Parameter(Mandatory = $False)] $library
)
try {
    # Modules
    Push-Location -Path $PSScriptRoot/../modules
        (Get-ChildItem -Directory).BaseName | Foreach-Object {
        Push-Location -Path $_
        Write-Host "📜 Generating '$_' Docs..." -ForegroundColor Magenta
        Get-Content TEMPLATE.md > README.md; "`n" >> README.md; terraform-docs md . >> README.md
        if ($tf) {
            try {
                terraform init -backend=false -upgrade
                Write-Host "✅ Terraform fmt & validate '$_'..." -ForegroundColor Magenta
                terraform fmt
                terraform validate
            }
            finally {
                Pop-Location
            }
        }
    }
    # Examples
    Push-Location -Path $PSScriptRoot/../
        (Get-ChildItem -Directory -Path examples*).BaseName | Foreach-Object {
        Push-Location -Path $_
        Write-Host "📜 Generating '$_' Docs..." -ForegroundColor Magenta
        Get-Content TEMPLATE.md > README.md; "`n" >> README.md; terraform-docs md . >> README.md
        if ($tf) {
            try {
                terraform init -backend=false -upgrade
                Write-Host "✅ Terraform fmt & validate '$_'..." -ForegroundColor Magenta
                terraform fmt
                terraform validate
            }
            finally {
                Pop-Location
            }
        }
    }
    # Update custom definition library readme
    if ($library) {
        Write-Host "📜 Generating Custom Library Docs..." -ForegroundColor Magenta
        & "$PSScriptRoot/markdown_generator.ps1"
    }
    # Return to original working directory
    Pop-Location; Pop-Location
}
catch { Write-Host "🥵 Could not complete precommit tasks: $_" -ForegroundColor Red }
