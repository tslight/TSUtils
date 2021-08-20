function ConvertTo-HashTable {
    [CmdletBinding()]
    Param (
	[Parameter(Mandatory,ValueFromPipeline)]
	[AllowNull()]
	[object]$Object
    )

    process {
	$HashTable = [ordered]@{}

	foreach ($Property in $Object.PSObject.Properties.Name) {
	    $HashTable[$Property] = $Object.$Property
	}

	Write-Output $HashTable
    }
}
