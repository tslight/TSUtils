function Write-ArchiveToMemory {
    [CmdletBinding()]
    Param (
	[Parameter(Mandatory,ValueFromPipeline)]
	[System.IO.FileInfo]$Archive
    )

    begin {
	[System.Reflection.Assembly]::LoadWithPartialName('System.IO.Compression') | Out-Null
    }

    process {
	foreach ($zip in $Archive) {
	    try {
		$MemoryStream = New-Object System.IO.Memorystream
		$ArchiveBytes = [System.IO.File]::ReadAllBytes($zip)
		$MemoryStream.Write($ArchiveBytes)
		Write-Verbose "Successfully read $zip into memory."
	    } catch {
		Write-Error $_.Exception.Message
	    }
	    New-Object System.IO.Compression.ZipArchive($MemoryStream)
	}
    }
}
