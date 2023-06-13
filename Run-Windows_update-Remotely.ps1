#thanks to https://stackoverflow.com/questions/7078958/powershell-remote-microsoft-update-session-access-denied-0x80070005
#Please do these commands in Target host before running the script 
#--------------------
#New-PSSessionConfigurationFile -RunAsVirtualAccount -Path .\VirtualAccount.pssc
## Note this will restart the WinRM service:
#Register-PSSessionConfiguration -Name 'VirtualAccount'  -Path .\VirtualAccount.pssc -Force
## Check the Permission property:
#Get-PSSessionConfiguration -Name 'VirtualAccount'
## Those users will have full unrestricted access to the system!
#--------------------
$computerName = "IP/Name"
$username = "admin user"
$password = ConvertTo-SecureString -String "password" -AsPlainText -Force
$cred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $username, $password
$session = @()

$script = {
            write-host "Hello from remote target"
            #filepath is in Remote/target host
            $job = Start-job -FilePath c:\Windows_Update_2.ps1 -Verbose -Credential $cred
            echo $job
            Wait-Job $job
            $output = Receive-Job $Job
            foreach ($item in $output){
                              write-host $item
                                }
           # write-host $output.Finished
            #write-host $output.JobStateInfo
            #$appJob.ChildJobs[0].Output
            }


$session = New-PSSession -ComputerName $computerName -Credential $cred  -ConfigurationName 'VirtualAccount' 
Invoke-Command -Session $session  -ScriptBlock $script
