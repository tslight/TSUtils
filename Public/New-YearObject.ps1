function New-YearObject {
    [CmdletBinding(SupportsShouldProcess)]
    Param ()

    $Year = New-Object PSObject

    for ($i=1; $i -le 12; $i++) {
	$Name = Get-Date -Month $i -UFormat '%b'
	$Month = New-MonthObject
	$Year | Add-Member -Membertype Noteproperty -Name $Name -Value $Month
    }

    return $Year
}
