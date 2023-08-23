$vsphereServer= "myserver@vcenter.local"
$User = "myuser@domain.com"
$Password = "mypass"
Connect-viserver -server $vsphereServer -User $User -Password $Password

# Temporarily change the error action preference
$ErrorActionPreference = "SilentlyContinue"
echo "Database:"
Invoke-GetHealthDatabase
$DBError =$Error[0].ToString()
echo "Database Storage:"
Invoke-GetHealthDatabaseStorage
$DBStorageError =$Error[0].ToString()
Invoke-GetHealthStorage
echo "Application Management:"
Invoke-GetHealthApplmgmt
echo "Load:"
Invoke-GetHealthLoad 
echo "Memory:"
Invoke-GetHealthMem
echo "Software Packages"
Invoke-GetHealthSoftwarePackages
echo "Swap:"
Invoke-GetHealthSwap

# Append the error to a log file

echo "system:"
Invoke-GetHealthSystem 
#----------------------------------------
# Reset error action preference to default value
$ErrorActionPreference = "Continue"
echo "these errors are happend:"
$DBError
$DBStorageError

