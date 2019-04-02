function Merge-Objects {
    [CmdletBinding(SupportsShouldProcess)]
    Param (
	[Parameter(Mandatory)]
	[AllowNull()]
	[object[]]$ObjectOne,
	[Parameter(Mandatory)]
	[AllowNull()]
	[object[]]$ObjectTwo
    )

    $Properties = [PSCustomObject]@()

    foreach ($Property in $Object1.PSObject.Properties) {
	$Properties += @{$Property.Name = $Property.Value}
    }

    foreach ($Property in $Object1.PSObject.Properties) {
	$Properties += @{$Property.Name = $Property.Value}
    }

    [PSCustomObject]$Properties
}
