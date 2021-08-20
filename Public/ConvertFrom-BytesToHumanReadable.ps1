function ConvertFrom-BytesToHumanReadable {
    [cmdletbinding()]
    Param (
	[Parameter(Mandatory,ValueFromPipeline)]
	[double]$Bytes
    )

    if ($Bytes -gt ([math]::pow(10, 9))) {
	$GB = [math]::Round($Bytes/1gb, 2)
	return "$GB GB"
    } elseif ($Bytes -gt ([math]::pow(10, 6))) {
	$MB = [math]::Round($Bytes/1mb, 2)
	return "$MB MB"
    } elseif ($Bytes -gt ([math]::pow(10, 3))) {
	$KB = [math]::Round($Bytes/1kb, 2)
	return "$KB KB"
    } else {
	return "$Bytes Bytes"
    }
}
