function New-YearsObject {
    [CmdletBinding(SupportsShouldProcess)]
    Param (
	[Parameter(Mandatory,ValueFromPipeline)]
	[string]$Year,
	[int]$Depth
    )

    begin {
	$YearsObject = New-Object PSObject
    }

    process {
	$YearObject = New-YearObject
	$YearsObject | Add-Member -MemberType NoteProperty -Name $Year -Value $YearObject
    }

    end {
	switch ($Depth) {
	    1        { $YearsObject | ConvertTo-Json -Depth 1 | ConvertFrom-Json }
	    2        { $YearsObject | ConvertTo-Json -Depth 2 | ConvertFrom-Json }
	    3        { $YearsObject | ConvertTo-Json -Depth 3 | ConvertFrom-Json }
	    default  { $YearsObject }
	}
    }
}
