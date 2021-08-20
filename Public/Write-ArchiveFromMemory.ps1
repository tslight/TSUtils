function Write-ArchiveFromMemory {
    [CmdletBinding()]
    Param (
	[Parameter(Mandatory,ValueFromPipeline)]
	[System.IO.Compression.ZipArchive]$ZipArchive,
	[System.IO.DirectoryInfo]$Destination=$(Read-Host "Enter a destination directory")
    )

    begin {
	[System.Reflection.Assembly]::LoadWithPartialName('System.IO.Compression') | Out-Null
    }

    process {
	foreach ($zip in $ZipArchive) {
	    foreach ($Entry in $zip.Entries) {
		try {
		    $Reader = New-Object System.IO.StreamReader($Entry.Open())
		    $Contents = $Reader.ReadToEnd()
		    Set-Content -Value $Contents -Path "$Destination\$($Entry.Name)"
		    Get-Item "$Destination\$($Entry.Name)"
		    Write-Verbose "Successfully wrote $($Entry.Name) to $Destination."
		} catch {
		    Write-Error. $_.Exception.Message
		}
	    }
	}
    }
}
