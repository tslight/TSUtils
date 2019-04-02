function Get-ModuleInfo {
    [CmdletBinding(SupportsShouldProcess)]
    Param (
	[Parameter(Mandatory,ValueFromPipeline)]
	[System.IO.FileInfo]$Path
    )

    $Public  = Get-ChildItem -Path "$Path\Public\*.ps1" -ErrorAction SilentlyContinue |
      Select-Object -ExpandProperty Fullname
    $Private = Get-ChildItem -Path "$Path\Private\*.ps1" -ErrorAction SilentlyContinue |
      Select-Object -ExpandProperty Fullname

    Write-Output "| **COMMAND** | **PARAMETER |"
    Write-Output "|:------------|:------------|"

    foreach ($Function in $Public) {
	. $Function
	$Function = ($Function | Split-Path -Leaf) -Replace '.ps1',''
	try {
	    $Params = Get-Params $Function
	} catch {
	    throw
	}

	$Params = Convert-Params $Params
	$Function = "| ``$Function``"

	Write-Output ("$Function $Params").Trim()
    }
}
