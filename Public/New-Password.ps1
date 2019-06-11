function New-Password {
    [CmdletBinding()]
    Param (
	[int]$Length=15,
	[switch]$Encrypt,
	[switch]$Test
    )

    $Chars = @()

    for ($c=33; $c -le 126; $c++) {
	$Chars += ,[char][byte]$c
    }

    for ($c=0; $c -le $Length; $c++) {
	$Password += $Chars | Get-Random
    }

    if ($Test) {
	if ($Encrypt) {
	    Test-Password $Password | ConvertTo-SecureString -AsPlainText -Force
	} else {
	    Test-Password $Password
	}
    } else {
	if ($Encrypt) {
	    ConvertTo-SecureString $Password -AsPlainText -Force
	} else {
	    Write-Output $Password
	}
    }
}
