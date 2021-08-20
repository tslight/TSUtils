function Get-SecureStringFromFile {
    [CmdletBinding()]
    Param (
	[SupportsWildcards()]
	[Parameter(Mandatory,ValueFromPipeline)]
	[string[]]$File
    )

    process {
	try {
	    Get-Content $File | ConvertTo-SecureString -ErrorAction Stop
	} catch {
	    Write-TSWarning `
	      -Exception $_ `
	      -Warning "Failed to retrieve secure string from $File." `
	      -Verbose:$VerbosePreference
	}
    }
}
