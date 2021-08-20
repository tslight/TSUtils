function New-Path {
    [CmdletBinding(SupportsShouldProcess)]
    param (
	[Parameter(Mandatory,Position=1)]
	[string]$Path,
	[Parameter(Mandatory,Position=2)]
	[string]$Type,
	[switch]$Force
    )

    if (Test-Path $Path) {
	Write-Verbose "$Path already exists."
    } else {
	try {
	    if ($Force -or $PSCmdlet.ShouldProcess("ShouldProcess?")) {
		New-Item -Path $Path -ItemType $Type -Force:$Force | Out-Null
	    }
	    Write-Verbose "Successfully created $Path."
	} catch {
	    Write-TSWarning `
	      -Exception $_ `
	      -Warning "Failed to create $Path." `
	      -Verbose:$VerbosePreference
	}
    }
}
