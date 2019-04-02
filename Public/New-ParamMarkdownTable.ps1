function New-ParamMarkdownTable {
    [CmdletBinding(SupportsShouldProcess)]
    Param (
	[Parameter(Mandatory,ValueFromPipeline)]
	[System.IO.FileInfo]$Path
    )

    begin {
	Write-Output "| **COMMAND** | **PARAMETER** |"
	Write-Output "|:------------|:--------------|"
    }

    process {
	. $Path
	$Function = ($Path | Split-Path -Leaf) -Replace '.ps1',''
	try {
	    $Params = Get-Params $Function
	} catch {
	    throw
	}

	$Params = Convert-ParamsToMarkdownRow $Params
	$Function = "| ``$Function``"

	Write-Output ("$Function $Params").Trim()
    }

    end {
	Write-Verbose "Finished processing "
    }
}
