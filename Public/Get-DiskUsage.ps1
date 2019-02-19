function Get-DiskUsage {
    [cmdletbinding()]
    Param (
	[Parameter(ValueFromPipeline)]
	[string]$Path="."
    )

    $Children = Get-Item -Force -LiteralPath $Path

    foreach ($Child in $Children) {
	[double]$Size += Get-ChildItem -Recurse -File $Child.FullName |
	  Measure-Object -Property Length -Sum |
	  Select -ExpandProperty Sum
    }

    return ConvertFrom-BytesToHumanReadable $Size
}
