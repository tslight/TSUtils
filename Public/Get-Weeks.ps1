function Get-Weeks {
    [CmdletBinding(SupportsShouldProcess)]
    Param (
	[Parameter(Mandatory,ValueFromPipeline)]
	[object]$Month
    )

    process {
	for ($i=1; $i -le 5; $i++) {
	    $Month."Week $i"
	}
    }
}
