function ConvertFrom-HashTable {
    [CmdletBinding()]
    Param (
	[Parameter(Mandatory,ValueFromPipeline)]
	[AllowNull()]
	[hashtable]$HashTable
    )

    process {
	New-Object PSObject -Property $HashTable
    }
}
