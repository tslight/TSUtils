function Export-ModuleParamsToMarkdown {
    [CmdletBinding(SupportsShouldProcess)]
    Param (
	[Parameter(Mandatory,ValueFromPipeline)]
	[System.IO.FileInfo]$ModulePath,
	[System.IO.FileInfo]$ExportPath="$ModulePath\README.md",
	[switch]$Overwrite
    )

    try {
	if ($Overwrite) {
	    Get-ModuleParamsInMarkdown $ModulePath |
	      Set-Content $ExportPath -ErrorAction Stop
	} else {
	    Get-ModuleParamsInMarkdown $ModulePath |
	      Add-Content $ExportPath -ErrorAction Stop
	}
    } catch [System.IO.IOException] {
	Write-Warning "$ExportPath is being used by another process."
    } catch {
	Write-Warning $_.InvocationInfo.ScriptName
	Write-Warning $_.InvocationInfo.Line
	Write-Warning $_.Exception.Message
    }
}
