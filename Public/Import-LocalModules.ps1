function Import-LocalModules {
    [cmdletbinding()]
    param (
	[Parameter(Position=1)]
	[array]$Include=@()
    )

    $ThisDir = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
    $Modules = @(Get-ChildItem -Path $ThisDir -Recurse "*.psm1" | ForEach-Object { $_.FullName })
    $Modules += $Include

    foreach ($module in $Modules) {
	try {
	    Import-Module $module -DisableNameChecking -Force
	    Write-Output "Successfully imported $module."
	} catch {
	    Write-Warning "Failed to import $module."
	    throw $_.Exception.Message
	}
    }
}
