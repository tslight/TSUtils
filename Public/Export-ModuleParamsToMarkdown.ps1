function Export-ModuleParamsToMarkdown {
    [CmdletBinding(SupportsShouldProcess)]
    Param (
	[Parameter(Mandatory,ValueFromPipelineByPropertyName)]
	[System.IO.FileInfo]$ModulePath,
	[Parameter(Mandatory,ValueFromPipelineByPropertyName)]
	[System.IO.FileInfo]$ExportPath,
	[switch]$Overwrite
    )

    if ($Overwrite) {
	Get-ModuleParamsInMarkdown $ModulePath | Set-Content $ExportPath
    } else {
	Get-ModuleParamsInMarkdown $ModulePath | Add-Content $ExportPath
    }
}
