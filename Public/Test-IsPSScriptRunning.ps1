function Test-IsPSScriptRunning {
    [CmdletBinding()]
    Param (
	[Parameter(Mandatory,ValueFromPipeline)]
	[string]$PSScript
    )
    process {
	if (Get-PSScriptProcess $PSScript) {
	    $True
	} else {
	    $False
	}
    }
}
