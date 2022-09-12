# PRECOMMIT TASKS

[CmdletBinding()]
Param(
    [switch] [Parameter(Mandatory = $False)] $tf
)
try {
    Push-Location -Path $PSScriptRoot/../modules
        (Get-ChildItem -Directory).BaseName | Foreach-Object {
        Push-Location -Path $_
        Write-Host "📜 Generating $_ Docs..." -ForegroundColor Magenta
        Get-Content TEMPLATE.md > README.md; "`n" >> README.md; terraform-docs md . >> README.md
        if ($tf) {
            Write-Host "✅ Terraform validate..." -ForegroundColor Magenta
            terraform fmt
            terraform validate
        }
        Pop-Location
    }
    Push-Location -Path $PSScriptRoot/../
        (Get-ChildItem -Directory -Path examples*).BaseName | Foreach-Object {
        Push-Location -Path $_
        Write-Host "📜 Generating $_ Docs..." -ForegroundColor Magenta
        Get-Content TEMPLATE.md > README.md; "`n" >> README.md; terraform-docs md . >> README.md
        if ($tf) {
            Write-Host "✅ Terraform validate..." -ForegroundColor Magenta
            terraform fmt
            terraform validate
        }
        Pop-Location
    }
    Pop-Location
    Pop-Location
}
catch { Write-Host "🥵 Could not complete precommit tasks: $_" -ForegroundColor Red }
