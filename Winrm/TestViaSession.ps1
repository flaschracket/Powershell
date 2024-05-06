$u = 'admin'
$p= 'SO'
$IP = '1.33.12.12'

$password = ConvertTo-SecureString -String $p -AsPlainText -Force
$credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $u
$session = New-PSSession -ComputerName $IP -Credential $u

$session

Remove-PSSession $session
