function Get-DiskUsage {
    [cmdletbinding()]
    Param (
	[Parameter(ValueFromPipeline)]
	[string]$Path=".",
	[switch]$Bytes
    )

    $Children = Get-Item -Force -LiteralPath $Path

    foreach ($Child in $Children) {
	[double]$Size += Get-ChildItem -Recurse -File $Child.FullName |
	  Measure-Object -Property Length -Sum |
	  Select-Object -ExpandProperty Sum
    }

    if ($Bytes) {
	Write-Output $Size
    } else {
	ConvertFrom-BytesToHumanReadable $Size
    }
}
