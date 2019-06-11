function Get-Days {
    [CmdletBinding(SupportsShouldProcess)]
    Param (
	[Parameter(Mandatory,ValueFromPipeline)]
	[object]$Week
    )

    process {
	for ($d=1; $d -le 7; $d++) {
	    $Day = Get-DayOfWeek $d
	    $Week.$Day
	}
    }
}
