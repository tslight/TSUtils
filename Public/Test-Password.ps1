function Test-Password {
    [CmdletBinding()]
    Param (
	[string]$Password=(Get-Password),
	[int]$Length=12
    )

    # At least 1 uppercase        (?=.*[A-Z])
    # At least 1 non-alphanumeric (?=.*[^a-zA-Z0-9])
    # At least 1 number           (?=.*[0-9])
    # At least 1 lowercase        (?=.*[a-z])
    # At least 10 chars long      {10,}
    # ?= is lookahead, ^ beginning of str, $ end of str
    $RegEx = "^(?=.*[A-Z])(?=.*[^a-zA-Z0-9])(?=.*[0-9])(?=.*[a-z]).{$Length,}$"

    if ($Password -cmatch $Regex) {
	Write-Verbose "Password is strong enough."
	Write-Output $Password
    } else {
	Write-Verbose "$Password too weak. Trying again..."
	Test-Password
    }
}
