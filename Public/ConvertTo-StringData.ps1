function ConvertTo-StringData {
    [CmdletBinding()]
    Param (
	[Parameter(Mandatory,ValueFromPipeline)]
	[object]$Object
    )

    process {
	foreach ($o in $Object) {
	    $o.GetEnumerator() | ForEach-Object {
		"{0} = {1}" -f $_.Name,(Expand-Value $_.Value)
	    }
	}
    }
}
