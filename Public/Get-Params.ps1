function Get-Params {
    [CmdletBinding(SupportsShouldProcess)]
    Param (
	[Parameter(Mandatory,ValueFromPipeline)]
	[string]$Function
    )

    begin {
	$Common = @(
	    'Debug',
	    'ErrorAction',
	    'ErrorVariable',
	    'InformationAction',
	    'InformationVariable',
	    'OutVariable',
	    'OutBuffer',
	    'PipelineVariable',
	    'Verbose',
	    'WarningAction',
	    'WarningVariable',
	    'WhatIf',
	    'Confirm'
	)
    }

    process {
	try {
	    $Params = (Get-Command $Function).Parameters | Select-Object -ExpandProperty Keys
	} catch {
	    throw
	}
	$Params | Where-Object {
	    if (!$Common.Contains($_)) {
		$_
	    }
	}
    }
}
