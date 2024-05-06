$username = 'a\admin'
$password='SeO'
$IP = '10.3.1.22'

[SecureString]$securepassword = ConvertTo-SecureString -String $password -AsPlainText -Force 
$credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $username, $securepassword
$session = New-PSSession -ComputerName $IP -Credential $credential

$session

Remove-PSSession $session
