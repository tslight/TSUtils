function New-Path {
    [cmdletbinding(SupportsShouldProcess)]
    param (
	[Parameter(Mandatory,Position=1)]
	[string]$Path,
	[Parameter(Mandatory,Position=2)]
	[string]$Type
    )

    if (Test-Path $Path) {
	Write-Verbose "$Path already exists."
    } else {
	try {
	    New-Item -Path $Path -ItemType $Type -Force | Out-Null
	    Write-Verbose "Successfully created $Path."
	} catch {
	    Write-Warning "Failed to create $Path."
	    throw $_.Exception.Message
	}
    }
}
