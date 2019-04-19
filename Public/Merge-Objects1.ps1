function Merge-Objects1 {
    [CmdletBinding()]
    Param (
	[Parameter(Mandatory,ValueFromPipeline)]
	[object[]]$Object
    )

    begin {
	$Properties = [ordered]@{}
	$Count = 0
    }

    process {
	foreach ($Property in $Object.PSObject.Properties) {
	    if ($Property.Value -ne $Null) {
		try {
		    $Properties.Add("$($Property.Name)", $Property.Value)
		} catch [System.Management.Automation.MethodInvocationException] {
		    Write-Warning "Duplicate property name. Adding underscore to second."
		    Write-Warning "To avoid this use the prefix parameters."
		    $Properties.Add("$($Property.Name)$Count", $Property.Value)
		}
	    }
	}
	$Count++
    }

    end {
	New-Object PSObject -Property $Properties
    }
}
