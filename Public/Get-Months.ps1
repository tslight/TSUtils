function Get-Months {
    [CmdletBinding(SupportsShouldProcess)]
    Param (
	[Parameter(Mandatory,ValueFromPipeline)]
	[object]$Year
    )

    process {
	for ($i=1; $i -le 12; $i++) {
	    $Name = Get-Date -Month $i -UFormat '%b'
	    $Year.$Name
	}
    }
}
