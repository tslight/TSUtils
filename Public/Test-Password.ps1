function Test-Password {
    [cmdletbinding(SupportsShouldProcess)]
    param (
	[Parameter(Position=1)]
	[string]$Password=(Get-Password)
    )

    # At least 1 uppercase        (?=.*[A-Z])
    # At least 1 non-alphanumeric (?=.*[^a-zA-Z0-9])
    # At least 1 number           (?=.*[0-9])
    # At least 1 lowercase        (?=.*[a-z])
    # At least 10 chars long      {10,}
    # ?= is lookahead, ^ beginning of str, $ end of str
    $RegEx = "^(?=.*[A-Z])(?=.*[^a-zA-Z0-9])(?=.*[0-9])(?=.*[a-z]).{10,}$"

    if ($Password -cmatch $Regex) {
	return $Password
    } else {
	Write-Warning "$Password too weak. Trying again..."
	return Test-Password
    }
}
