function ConvertTo-Markdown {
    [CmdletBinding(SupportsShouldProcess)]
    Param (
	[Parameter(Mandatory,ValueFromPipeline)]
	[object]$Object
    )

    $Properties = ($Object).PSStandardMembers
    $Properties = $Properties.DefaultDisplayPropertySet
    $Properties = $Properties.ReferencedPropertyNames | Select-Object -Unique

    $Header = ""
    $Header = $Properties | % { "$Header | **$_** |" }
    $Line = ""
    $Line = $Properties | % { "$Line |:---" }
    $Output = @(
	$Header,
	$Line
    )

    write-output $Output
    foreach ($Property in $Properties) {

    }
}
