function Get-LocalVariables {
    Param (
	[string]$Foo,
	[string]$Bar,
	[string]$Baz
    )

    $ParameterList = (Get-Command -Name $MyInvocation.InvocationName).Parameters

    foreach ($key in $ParameterList.keys) {
	Get-Variable -Name $key -ErrorAction SilentlyContinue
    }
}
