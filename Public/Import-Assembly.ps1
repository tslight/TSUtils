function Import-Assembly {
    [CmdletBinding()]
    Param(
	[Parameter(Mandatory,ValueFromPipeline)]
	[ValidateNotNullOrEmpty()]
	[System.IO.FileInfo[]]$AssemblyPath
    )

    process {
	foreach ($Path in $AssemblyPath) {
	    $DLL = $Path | Split-Path -Leaf

	    $Assembly = [AppDomain]::CurrentDomain.GetAssemblies() | Where-Object {
		$_.Location -match $DLL
	    }

	    if ($Assembly) {
		Write-Verbose "$Path already loaded."
		Write-Output $True
	    } else {
		Write-Verbose "Loading $Path..."
		try {
		    [Void][System.Reflection.Assembly]::LoadFrom($Path)
		    Write-Verbose "Successfully loaded $Path."
		    Write-Output $True
		} catch {
		    Write-Error $_
		}
	    }
	}
    }
}
