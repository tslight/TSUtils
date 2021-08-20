function Get-CsvColumn {
    [CmdletBinding()]
    Param (
	[Parameter(Mandatory,ValueFromPipeline)]
	[System.IO.FileInfo]$Csv,
	[Parameter(Mandatory)]
	[string]$Column
    )

    begin {
	$msg = "Getting $Column column from $Csv..."
	Write-Host -Back Black -Fore Magenta $msg
    }

    process {
	Import-Csv $Csv |
	  Where-Object { $_.$Column -ne 'None' -Or $_.$Column -match '^$|^\s+$' } |
	  Select-Object -ExpandProperty $Column
    }

    end {
	$msg = "Finished getting $Column column from $Csv..."
	Write-Host -Back Black -Fore Cyan $msg
    }
}
