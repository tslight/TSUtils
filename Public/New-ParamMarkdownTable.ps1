function New-ParamMarkdownTable {
    [CmdletBinding(SupportsShouldProcess)]
    Param (
	[Parameter(Mandatory,ValueFromPipeline)]
	[System.IO.FileInfo[]]$Path
    )

    begin {
	Write-Output (
	    "| **CMDLET** | **SYNOPSIS** | **PARAMETER** | **DESCRIPTION** |`n" +
	    "|:-----------|:-------------|:--------------|:----------------|"
	)
    }

    process {
	. $Path
	$Function = ($Path | Split-Path -Leaf) -Replace '.ps1',''
	try {
	    $Synopsis = (Get-Help $Function).Synopsis.Trim() -Replace "\[|\]|<|>","" -Replace "`n", " "
	    if ($Synopsis -match "^$Function .*") {
		$Synopsis = ""
	    }
	    if ($Params = Get-Parameters $Function) {
		$Params = Convert-ParamsToMarkdownRow $Params
		$Function = "| ``$Function``"
		$Synopsis = "| $Synopsis"
		Write-Output ("$Function $Synopsis $Params").Trim()
	    } else {
		$Function = "| ``$Function``"
		$Synopsis = "| $Synopsis | | |"
		Write-Output "$Function $Synopsis"
	    }
	} catch {
	    Write-TSWarning $_ -Verbose:$VerbosePreference
	    throw
	}
    }

    end {
	Write-Verbose "Finished processing "
    }
}
