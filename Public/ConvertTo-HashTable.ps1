function ConvertTo-HashTable {
    [CmdletBinding()]
    Param (
	[Parameter(Mandatory,ValueFromPipeline)]
	[AllowNull()]
	[object]$Object
    )

    process {
	$HashTable = @{}

	foreach ($Property in $Object.PSObject.Properties.Name) {
	    $HashTable[$Property] = $Object.$Property
	}

	return $HashTable
    }
}
