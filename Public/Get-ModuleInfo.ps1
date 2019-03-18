function Get-ModuleInfo {
    [CmdletBinding(SupportsShouldProcess)]
    Param (
	[Parameter(Mandatory,ValueFromPipeline)]
	[System.IO.FileInfo]$Path
    )

    $Common = @(
	'Debug',
	'ErrorAction',
	'ErrorVariable',
	'InformationAction',
	'InformationVariable',
	'OutVariable',
	'OutBuffer',
	'PipelineVariable',
	'Verbose',
	'WarningAction',
	'WarningVariable',
	'WhatIf',
	'Confirm'
    )

    $Functions = (Get-ChildItem $Path | Select-Object -ExpandProperty Name) -Replace '.ps1',''

    foreach ($Function in $Functions) {
	$Params = (Get-Command $Function).Parameters | Select-Object -ExpandProperty Keys
	$Params = $Params | % { if (!$Common.Contains($_)) { $_ } }
	if ($Params.Length -eq 1) {
	    $NewParams = $Params | % { "| ``$_`` |"}
	} else {
	    $NewParams = @()
	    foreach ($Param in $Params) {
		if ($Params.IndexOf($Param) -eq 0) {
		    $NewParams += "| ``$Param`` |`n"
		} else {
		    $NewParams += "|`t| ``$Param`` |`n"
		}
	    }
	}
	$Function = "| ``$Function``"
	Write-Output ("$Function $NewParams").Trim()
    }
}
