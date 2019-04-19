function Write-TSWarning {
    [CmdletBinding()]
    Param (
	[Parameter(Mandatory,ValueFromPipeline)]
	[object]$Exception,
	[string]$Warning
    )

    process {
	$Path = ($Exception.InvocationInfo.ScriptName | Out-String).Trim()
	$Line = ($Exception.InvocationInfo.Line | Out-String).Trim()
	$Msg  = ($Exception.Exception.Message | Out-String).Trim()

	if ($Warning) {
	    Write-Warning $Warning
	}

	Write-Verbose "PATH: $Path"
	Write-Verbose "LINE: $Line"
	Write-Warning "$Msg"
    }
}
