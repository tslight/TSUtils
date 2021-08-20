function Write-StdOutAndLog {
    [cmdletbinding()]
    param (
	[Parameter(Mandatory,Position=1)]
	[AllowEmptyString()]
	[string]$msg,
	[Parameter(Mandatory,Position=2)]
	[string]$log,
	[switch]$Overwrite
    )

    Write-Output $msg

    if ($Overwrite) {
	Set-Content $log $msg
    } else {
	Add-Content $log $msg
    }
}
