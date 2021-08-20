function Expand-Value {
    [CmdletBinding()]
    Param (
	[Parameter(Mandatory,ValueFromPipeline)]
	[AllowNull()]
	[AllowEmptyString()]
	[object]$Value
    )

    process {
	foreach ($v in $Value) {
	    if ($v -ne $Null) {
		switch ($v.GetType().Name) {
		    'String' { "`"$value`"" }
		    'Boolean' { "`"$value`"" }
		    default { $v }
		}
	    } else {
		""
	    }
	}
    }
}
