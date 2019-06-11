function Get-RandomLetters {
    [CmdletBinding(SupportsShouldProcess)]
    Param (
	[int]$Length=5,
	[switch]$Lower,
	[switch]$Upper
    )

    $Chars = @()

    $Chars = Get-Alphabet -Lower:$Lower -Upper:$Upper

    for ($c=0; $c -le $Length; $c++) {
	$Letters += $Chars | Get-Random
    }

    Write-Output $Letters
}
