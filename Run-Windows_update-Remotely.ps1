
$computerName = "IP/Name"
$username = "admin user"
$password = ConvertTo-SecureString -String "password" -AsPlainText -Force
$cred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $username, $password
$session = @()

$script = {
            write-host "Hello from remote target"
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
