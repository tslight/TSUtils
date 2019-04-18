function Write-TSWarning {
    [CmdletBinding(SupportsShouldProcess)]
    Param (
	[Parameter(Mandatory)]
	[object]$Exception
    )

    $Path = $Exception.InvocationInfo.ScriptName
    $Line = $Exception.InvocationInfo.Line
    $Msg  = $Exception.Exception.Message

    Write-Warning "PATH: $(($Path | Out-String).Trim())"
    Write-Warning "LINE: $(($Line | Out-String).Trim())"
    Write-Warning "MESSAGE: $(($Msg | Out-String).Trim())"
}
