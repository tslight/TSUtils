function Expand-ArchiveToTemp {
    [CmdletBinding()]
    Param (
	[Parameter(Mandatory,ValueFromPipeline)]
	[System.IO.FileInfo[]]$Archive,
	[string]$Directory
    )

    begin {
	if (-Not $Directory) {
	    $Directory = $Archive.BaseName
	}
    }

    process {
	foreach ($zip in $Archive) {
	    $TmpPath = [System.IO.Path]::GetTempPath()
	    $TmpPath = "$TmpPath\$Directory"

	    if (Test-Path $TmpPath) {
		Write-Verbose "$TmpPath already exists."
	    } else {
		try {
		    $TmpPath = New-Item -Path $TmpPath -ItemType Directory -ErrorAction Stop
		    Write-Verbose "Successfully created $TmpPath."
		} catch {
		    Write-Error $_.Exception.Message
		}
	    }

	    Write-ArchiveToMemory -Archive $zip |
	      Write-ArchiveFromMemory -Destination $TmpPath
	}
    }
}
