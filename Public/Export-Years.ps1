Function Export-Years {
    [CmdletBinding(SupportsShouldProcess)]
    Param (
	[Parameter(Mandatory,ValueFromPipeline)]
	[object]$Years,
	[Parameter(Mandatory)]
	[System.IO.FileInfo]$Path
    )

    begin {
	$YearsArr = $Years.PSObject.Properties.Name | ? { $_ -match '^\d{4}$' }
    }

    process {
	$YearsArr | Export-Year -Path $Path
    }
}
