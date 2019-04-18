function Write-TSWarning {
    [CmdletBinding(SupportsShouldProcess)]
    Param (
	[Parameter(Mandatory,ValueFromPipeline)]
	[object]$Exception
    )

    $Path = ($Exception.InvocationInfo.ScriptName | Out-String).Trim()
    $Line = ($Exception.InvocationInfo.Line | Out-String).Trim()
    $Msg  = ($Exception.Exception.Message | Out-String).Trim()

    Write-Verbose "PATH: $Path"
    Write-Verbose "LINE: $Line"
    Write-Warning "$Msg"
}
