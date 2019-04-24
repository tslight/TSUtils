function Add-DefaultDisplaySet {
    [CmdletBinding(SupportsShouldProcess)]
    Param (
	[Parameter(Mandatory,ValueFromPipeline)]
	[object]$Object,
	[Parameter(Mandatory)]
	[string]$TypeName, # Give this object a unique typename
	[Parameter(Mandatory)]
	[array]$DefaultDisplaySet # Configure a default display set
    )

    process {
	# https://learn-powershell.net/2013/08/03/quick-hits-set-the-default-property-display-in-powershell-on-custom-objects/
	$Object.PSObject.TypeNames.Insert(0,$TypeName)
	# Create the default property display set
	$DefaultDisplayPropertySet = New-Object System.Management.Automation.PSPropertySet(
	    ‘DefaultDisplayPropertySet’,[string[]]$DefaultDisplaySet
	)
	$PSStandardMembers = [System.Management.Automation.PSMemberInfo[]]@($DefaultDisplayPropertySet)
	$Object | Add-Member MemberSet PSStandardMembers $PSStandardMembers
	Write-output $Object
    }
}
