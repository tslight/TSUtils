function Merge-MultipleObjects {
    [CmdletBinding()]
    Param (
	[Parameter(Mandatory,ValueFromPipeline)]
	[object[]]$Objects
    )

    begin {
	$Properties = [ordered]@{}
	$Count = 1
    }

    process {
	foreach ($Object in $Objects) {
	    foreach ($Property in $Object.PSObject.Properties) {
		if ($Property.Value -ne $Null) {
		    try {
			$Properties.Add("$($Property.Name)", $Property.Value)
		    } catch [System.Management.Automation.MethodInvocationException] {
			Write-Verbose "Duplicate property name. Adding $Count counter."
			$Properties.Add("$($Property.Name)-$Count", $Property.Value)
		    }
		}
	    }
	$Count++
	}
    }

    end {
	New-Object PSObject -Property $Properties
    }
}
