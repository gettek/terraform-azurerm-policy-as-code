Push-Location "../"

try {
    $Directories = Get-ChildItem -Recurse -Directory:$true

    $directories | ForEach-Object {
        $directory = $PSItem
        if ($directory.GetFiles('*.tf*')) {
            Push-Location "$($Directory.FullName)"
            try {
                terraform fmt    
            }
            finally {
                Pop-Location
            }
        }
    }
}
finally {
    Pop-Location
}