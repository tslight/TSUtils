function Merge-TwoObjects {
    [CmdletBinding(SupportsShouldProcess)]
    Param (
	[Parameter(Mandatory)]
	[AllowNull()]
	[object]$ObjectOne,
	[Parameter(Mandatory)]
	[AllowNull()]
	[object]$ObjectTwo,
	[AllowEmptyString()]
	[string]$PrefixOne,
	[AllowEmptyString()]
	[string]$PrefixTwo
    )

    $Properties = [ordered]@{}

    foreach ($Property in $ObjectOne.PSObject.Properties) {
	if ($Property.Value -ne $Null) {
	    $Properties.Add("$PrefixOne$($Property.Name)", $Property.Value)
	}
    }

    foreach ($Property in $ObjectTwo.PSObject.Properties) {
	if ($Property.Value -ne $Null) {
	    try {
		$Properties.Add("$PrefixTwo$($Property.Name)", $Property.Value)
	    } catch [System.Management.Automation.MethodInvocationException] {
		Write-Warning "Duplicate property name. Adding underscore to second."
		Write-Warning "To avoid this use the prefix parameters."
		$Properties.Add("$($Property.Name)_", $Property.Value)
	    }
	}
    }

    New-Object PSObject -Property $Properties
}
