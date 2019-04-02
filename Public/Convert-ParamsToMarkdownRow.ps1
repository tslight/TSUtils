function Convert-ParamsToMarkdownRow {
    [CmdletBinding(SupportsShouldProcess)]
    Param (
	[Parameter(Mandatory,ValueFromPipeline)]
	[array]$Params
    )

    if ($Params.Length -le 1) {
	$Params | % { "| ``$_`` |"}
    } else {
	foreach ($Param in $Params) {
	    if ($Params.IndexOf($Param) -eq 0) {
		Write-Output "| ``$Param`` |`n"
	    } else {
		Write-Output "|`t| ``$Param`` |`n"
	    }
	}
    }
}
