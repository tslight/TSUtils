function Get-Years {
    [CmdletBinding(SupportsShouldProcess)]
    Param (
	[Parameter(Mandatory,ValueFromPipeline)]
	[object]$YearsObject
    )

    process {
	$Years = $YearsObject.PSObject.Properties.Name | ? { $_ -match '^\d{4}$' }
	foreach ($Year in $Years) { $YearsObject.$Year }
    }
}
