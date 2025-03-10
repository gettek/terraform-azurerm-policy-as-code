<#
Generates Markdown based on local library policy definition content
The output is stored in policies/README.md
#>

$ErrorActionPreference = 'SilentlyContinue'

Push-Location -Path "$PSScriptRoot/../policies"

$definitionChildrenDir = Get-ChildItem -Recurse -Directory | Sort-Object -Property "Name"
$definitionChildren = Get-ChildItem -Recurse -File -Include "*.json" -Exclude "example*.json" | Sort-Object -Property "Directory.Name"

$definitionList = [ordered]@{}
foreach ($category in $definitionChildrenDir.Name) {
    $definitionList[$category] = @()
}

foreach ($child in $definitionChildren) {
    $content = Get-Content -Path $child.FullName | ConvertFrom-Json

    $BaseName = try { $child.BaseName } catch { "" }
    $Name = try { $content.name } catch { "" }
    $Description = try { $content.properties.description.Replace("\n", " ") } catch { "" }
    $DisplayName = try { $content.properties.displayName } catch { "" }
    $Version = try { $content.properties.metadata.version } catch { @{} }
    $Effect = try { $content.properties.policyRule.then.effect } catch { "" }

    if ($child.BaseName -notin $definitionList[$child.Directory.Name].BaseName) {

        [PSObject]$object = [ordered]@{
            "BaseName"    = $BaseName
            "Name"        = $Name
            "Description" = $Description
            "DisplayName" = $DisplayName
            "Version"     = $Version
            "Effect"      = $Effect
        }

        $definitionList[$child.Directory.Name] += $object

        if ($content.properties.parameters | Get-Member -MemberType "NoteProperty") {
            [array]$paramsList = @()

            foreach ($param in $content.properties.parameters.PSObject.properties) {
                [PSObject]$thisParam = [ordered]@{
                    "Name"        = $param.Name
                    "Description" = $param.Value.metadata.description
                }

                if ($param.Value.defaultValue) {
                    $thisParam | Add-Member -NotePropertyName "DefaultValue" -NotePropertyValue $param.Value.defaultValue
                }

                if ($param.Value.allowedValues) {
                    $thisParam | Add-Member -NotePropertyName "AllowedValues" -NotePropertyValue $param.Value.allowedValues
                }

                $paramsList += $thisParam
            }

            $object | Add-Member -NotePropertyName "Parameters" -NotePropertyValue $paramsList
        }
    }
    else {
        throw "`nDuplicate Name!"
    }
}

# Output to Mardown
$heading = "`n# Custom Policy Definition Library"
$file = "README.md"

Write-Output "$heading" | Out-File -FilePath $file -Force
$append = @{
    "Append"   = $true
    "FilePath" = $file
}

Write-Output "`nExample custom definitions - Compile time: $(Get-Date)" | Out-File @append

Write-Output "`n## Categories" | Out-File @append
foreach ($definition in $definitionList.Keys) {
    Write-Output "- [$definition](#$($definition.Replace(" ","-")))" | Out-File @append
}

Write-Output "`n# Definitions" | Out-File @append
foreach ($definition in $definitionList.Keys) {
    Write-Output "`n## $definition" | Out-File @append

    foreach ($item in $definitionList[$definition]) {

        Write-Output "`n### 📜 [$($item.BaseName)](./$($definition.Replace(" ","%20"))/$($item.BaseName).json)" | Out-File @append
        Write-Output "| Title | Description |"                                           | Out-File @append
        Write-Output "| ----- | ----------- |"                                           | Out-File @append
        Write-Output "| Name                | $($item.Name) |"                           | Out-File @append
        Write-Output "| DisplayName         | $($item.DisplayName) |"                    | Out-File @append
        Write-Output "| Description         | $($item.Description.Replace("`n", " ")) |" | Out-File @append
        Write-Output "| Version             | $($item.Version) |"                        | Out-File @append
        Write-Output "| Effect              | $($item.Effect) |"                         | Out-File @append


        if ($item | Get-Member -MemberType "NoteProperty") {
            Write-Output "`n#### 🧮 ~ Parameters" | Out-File @append
            Write-Output "| Name | Description | Default Value | Allowed Values |"   | Out-File @append
            Write-Output "| ---- | ----------- | ------------- | -------------- |"   | Out-File @append

            foreach ($param in $item.parameters) {
                Write-Output "| $($param.Name) | $($param.Description) | $($param.DefaultValue) | $($param.AllowedValues) |" | Out-File @append
            }
        }

        Write-Output "`n<br>" | Out-File @append
        Write-Output "`n<br>" | Out-File @append
    }

    Write-Output "`n---" | Out-File @append
}

Pop-Location
