function Convert-ParamsToMarkdownRow {
    [CmdletBinding(SupportsShouldProcess)]
    Param (
	[Parameter(Mandatory,ValueFromPipeline)]
	[object[]]$Params
    )

    process {
	if ($Params -is [array]) {
	    foreach ($Param in $Params) {
		$Name = $Param.Name
		$Desc = $Param.Description -Replace "`n"," "
		if ($Params.IndexOf($Param) -eq 0) {
		    Write-Output "| ``-$Name``| $Desc |`n"
		} else {
		    Write-Output "|`t|`t| ``-$Name``| $Desc |`n"
		}
	    }
	} else {
	    $Name = $Params.Name
	    $Desc = $Params.Description -Replace "`n"," "
	    Write-Output "| ``-$Name`` | $Desc |`n"
	}
    }
}
