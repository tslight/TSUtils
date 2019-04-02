function Get-ModuleParamsInMarkdown {
    [CmdletBinding(SupportsShouldProcess)]
    Param (
	[Parameter(Mandatory,ValueFromPipelineByPropertyName)]
	[System.IO.FileInfo]$ModulePath
	[Parameter(Mandatory,ValueFromPipelineByPropertyName)]
	[System.IO.FileInfo]$ExportPath
    )

    Write-Output "`n<a id='public'></a>`r## PUBLIC COMMANDS`n"

    Get-ChildItem -Path "$ModulePath\Public\*.ps1" -ErrorAction SilentlyContinue |
      Select-Object -ExpandProperty Fullname |
      New-ParamMarkdownTable

    Write-Output "`n<a id=='private'></a>`r## PRIVATE FUNCTIONS`n"

    Get-ChildItem -Path "$ModulePath\Private\*.ps1" -ErrorAction SilentlyContinue |
      Select-Object -ExpandProperty Fullname |
      New-ParamMarkdownTable
}
