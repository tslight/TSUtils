function Add-DefaultDisplaySet {
    [CmdletBinding(SupportsShouldProcess)]
    Param (
	[Parameter(Mandatory,ValueFromPipeline)]
	[object]$Object,
	[Parameter(Mandatory)]
	[array]$DefaultDisplaySet, # Configure a default display set
	[string]$TypeName # Give this object a unique typename
    )

    process {
	# https://learn-powershell.net/2013/08/03/quick-hits-set-the-default-property-display-in-powershell-on-custom-objects/
	if ($TypeName) {
	    $Object.PSObject.TypeNames.Insert(0,$TypeName)
	}
	# Create the default property display set
	$DefaultDisplayPropertySet = New-Object System.Management.Automation.PSPropertySet(
	    ‘DefaultDisplayPropertySet’,[string[]]$DefaultDisplaySet
	)
	$PSStandardMembers = [System.Management.Automation.PSMemberInfo[]]@($DefaultDisplayPropertySet)
	$Object | Add-Member MemberSet PSStandardMembers $PSStandardMembers
	Write-Output $Object
    }
}
