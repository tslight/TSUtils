function Get-ModuleInfo {
    [CmdletBinding(SupportsShouldProcess)]
    Param (
	[Parameter(Mandatory,ValueFromPipeline)]
	[System.IO.FileInfo]$Path
    )

    $Functions = Get-ChildItem $Path | Select-Object -ExpandProperty Fullname

    foreach ($Function in $Functions) {
	. $Function
	$Function = ($Function | Split-Path -Leaf) -Replace '.ps1',''
	try {
	    $Params = Get-Params $Function
	} catch {
	    throw
	}
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
