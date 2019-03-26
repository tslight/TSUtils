function Test-IsPSScriptRunning {
    [CmdletBinding(SupportsShouldProcess)]
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
