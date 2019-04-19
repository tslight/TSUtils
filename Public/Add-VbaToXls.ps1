function Add-VbaToXls {
    [CmdletBinding()]
    Param (
	[Parameter(Mandatory,ValueFromPipeline)]
	[System.IO.FileInfo]$Xlsx,
	[Parameter(Mandatory)]
	[string]$VbaCode
    )

    begin {
	$Excel               = New-Object -com Excel.Application
	$Excel.DisplayAlerts = $False
	$Excel.Visible       = $False
	# Disable macro security, reenabled later
	$ExcelRegPath    = "HKCU:\Software\Microsoft\Office\$($Excel.Version)\Excel\Security"
	$Params          = @{
	    Path         = $ExcelRegPath
	    Name         = 'AccessVBOM'
	    PropertyType = 'DWORD'
	    Value        = 1
	    Force        = $True
	}
	New-ItemProperty @Params | Out-Null
	$Params['Name'] = 'VBAWarnings'
	New-ItemProperty @Params | Out-Null
    }

    process {
	Write-Host "Adding VBA code to $Xlsx"
	Write-Verbose "VBA = $VbaCode"
	$Xlsm = $Xlsx -Replace (".xlsx",".xlsm")
	$Workbook = $Excel.Workbooks.Open($Xlsx)
	# Add the VBA code to the first sheet
	$VBModule = $Workbook.VBProject.VBComponents.Item('Sheet1')
	$VBModule.CodeModule.AddFromString($VbaCode)
	Write-Host "Saving new macro enabled spreadsheet to $Xlsm"
	# https://www.microsoft.com/en-us/microsoft-365/blog/2009/07/07/use-the-vba-saveas-method-in-excel-2007/
	$Workbook.SaveAs($Xlsm, 52)
	$Workbook.Close()
    }

    end {
	$Excel.Quit()
	[System.Runtime.Interopservices.Marshal]::ReleaseComObject($Excel) | Out-Null
	if (Get-Process Excel -ErrorAction SilentlyContinue) {
	    Stop-Process -Name Excel
	}
    }
}
