function Get-DayOfWeek {
    [CmdletBinding(SupportsShouldProcess)]
    Param (
	[Parameter(Mandatory,ValueFromPipeline)]
	[int]$Day
    )

    process {
	$Days = @{
	    1 = 'Sun'
	    2 = 'Mon'
	    3 = 'Tue'
	    4 = 'Wed'
	    5 = 'Thu'
	    6 = 'Fri'
	    7 = 'Sat'
	}
	$Days[$Day]
    }
}
