function Get-ModuleParamsInMarkdown {
    [CmdletBinding(SupportsShouldProcess)]
    Param (
	[Parameter(Mandatory,ValueFromPipeline)]
	[System.IO.FileInfo[]]$ModulePath
    )

    process {
	Write-Output "<a id='public'></a>"
	Write-Output "## PUBLIC CMDLETS`n"

	Get-ChildItem -Path "$ModulePath\Public\*.ps1" -ErrorAction SilentlyContinue |
	  Select-Object -ExpandProperty Fullname |
	  New-ParamMarkdownTable

	Write-Output "`n<a id='private'></a>"
	Write-Output "## PRIVATE FUNCTIONS`n"

	Get-ChildItem -Path "$ModulePath\Private\*.ps1" -ErrorAction SilentlyContinue |
	  Select-Object -ExpandProperty Fullname |
	  New-ParamMarkdownTable
    }
}
