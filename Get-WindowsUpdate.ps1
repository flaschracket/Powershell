#Requires -Version 5.1

<#
.SYNOPSIS
    
.DESCRIPTION

.NOTES
    This PowerShell script was developed to test ScriptRunner. The use of the scripts requires ScriptRunner. 
    
.COMPONENT

.LINK
    https://github.com/flaschracket/Powershell/new/main

.Parameter LogPath
    Specifies the full path to which Get-WindowsUpdateLog writes WindowsUpdate.log, e.g. C:\Temp\WindowsUpdate.log. 
    The default value is WindowsUpdate.log in the Desktop folder of the current user
    
.Parameter ComputerName
    Specifies an remote computer, if the name empty the local computer is used

.Parameter AccessAccount
    Specifies a user account that has permission to perform this action. If Credential is not specified, the current user account is used.
#>

[CmdLetBinding()]
Param(
    [string]$LogPath,
    [string]$ComputerName,    
    [PSCredential]$AccessAccount
)

try{
    $Script:output
    $Script:output = Invoke-Command -ComputerName $ComputerName -ScriptBlock{
                    Get-WindowsUpdate -LogPath $Using:LogPath -Confirm:$false -ErrorAction Stop
                } -ErrorAction Stop
     
    if($SRXEnv) {
        $SRXEnv.ResultMessage = $Script:output
    }
    else{
        Write-Output $Script:output
    }
}
catch{
    throw
}
finally{
}
