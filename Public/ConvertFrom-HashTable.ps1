function ConvertFrom-HashTable {
    [CmdletBinding(SupportsShouldProcess)]
    Param (
	[Parameter(Mandatory,ValueFromPipeline)]
	[AllowNull()]
	[hashtable]$HashTable
    )

    process {
	New-Object PSObject -Property $HashTable
    }
}
