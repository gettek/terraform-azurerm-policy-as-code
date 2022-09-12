<#
.SYNOPSIS
    Converts Policy library from version 1 to version 2 of the terraforom-azure-policy-as-code repo
.PARAMETER clean
    Removes old policy directories and files leaving only the single converted policy json under the category folder
#>

[CmdletBinding()]
Param(
    [switch] [Parameter(Mandatory = $false)] $clean
)

$ErrorActionPreference = "Stop"
$VerbosePreference = "Continue"

if ($clean) {
    $confirmation = Read-Host "Are you sure want to remove all old policies and directories? [y/n]"
    while ($confirmation -ne "y") {
        if ($confirmation -eq 'n') { throw "Files will not be converted" }
    }
}

try {
    # check dependancies
    if ($PSVersionTable.PSVersion.Major -lt 7) { throw "Please use PowerShell >= 7.0" }

    Push-Location -Path "$PSScriptRoot/../policies"

    $categories = (Get-ChildItem -Directory).BaseName
    $categories | Foreach-Object {

        $category = $_
        Push-Location -Path $_

        $policies = (Get-ChildItem -Directory).BaseName
        $policies | Foreach-Object {
            Push-Location -Path $_

            # get old policy files
            $params = Get-Content "parameters.json" | ConvertFrom-Json
            $rules = Get-Content "rules.json" | ConvertFrom-Json

            # build a custom policy object
            $policy_oject = [ordered]@{
                type       = "Microsoft.Authorization/policyDefinitions"
                name       = $_
                properties = [ordered]@{
                    metadata   = @{
                        category = $category
                    }
                    parameters = $params
                    policyRule = $rules
                }
            }

            # Create new policy file
            Pop-Location
            Write-Host "Creating new file $category/$_.json"
            $policy_oject | ConvertTo-Json -Depth 100 | Out-File "$_.json" -Force

            # remove old directories
            if ($clean) {
                Remove-Item -Path $_ -Recurse -Verbose
            }
        }
        Pop-Location
    }
    Pop-Location
}
catch {
    # get a generic error record
    [System.Management.Automation.ErrorRecord]$e = $_

    # retrieve information about runtime error
    $info = [PSCustomObject]@{
        Column    = $e.InvocationInfo.OffsetInLine
        Exception = $e.Exception.Message
        Line      = $e.InvocationInfo.ScriptLineNumber
        Reason    = $e.CategoryInfo.Reason
        Script    = $e.InvocationInfo.ScriptName
        Target    = $e.CategoryInfo.TargetName
    }
    #Write the error object
    $info
    # Return to original working directory
    Pop-Location
    Write-Error -Message $_.Exception -ErrorAction "stop"
}
