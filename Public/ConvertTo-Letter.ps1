function ConvertTo-Letter {
    [CmdletBinding()]
    Param (
	[Parameter(Mandatory,ValueFromPipeline)]
	[int]$Number
    )

    if ($Number -gt 0 -And $Number -le 26) {
	[char]($Number + 64)
    } else {
	Write-Warning "Enter a number between 1 and 26..."
    }
}
