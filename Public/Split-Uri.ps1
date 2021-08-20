function Split-Uri {
    [CmdletBinding()]
    Param (
	[Parameter(Mandatory,ValueFromPipeline)]
	[string[]]$Uri,
	[switch]$Domain,
	[switch]$Path
    )

    process {
	foreach ($u in $Uri) {
	    [uri]$u = $u
	    if ($Domain) {
		[string]"$($u.scheme)://$($u.Authority)"
	    } elseif ($Path) {
		[string]"$($u.PathAndQuery)"
	    } else {
		[PSCustomObject]@{
		    Domain = [string]"$($u.scheme)://$($u.Authority)"
		    Path = [string]"$($u.PathAndQuery)"
		}
	    }
	}
    }
}
