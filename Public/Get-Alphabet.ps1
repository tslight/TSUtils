function Get-Alphabet {
    [CmdletBinding(SupportsShouldProcess)]
    Param (
	[switch]$Upper,
	[switch]$Lower
    )

    if ($Lower) {
	for ($c=1; $c -le 26; $c++) {
	    [char]($c+96)
	}
    } elseif ($Upper) {
	for ($c=1; $c -le 26; $c++) {
	    [char]($c+64)
	}
    } else {
	for ($c=1; $c -le 26; $c++) {
	    [char]($c+96)
	}
	for ($c=1; $c -le 26; $c++) {
	    [char]($c+64)
	}
    }
}
