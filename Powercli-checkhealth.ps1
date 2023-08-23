Connect-VCenter
# Temporarily change the error action preference
$ErrorActionPreference = "SilentlyContinue"

echo "check powercli"
Invoke-GetHealthDatabase
$DBError =$Error[0].ToString()
Invoke-GetHealthDatabaseStorage
$DBStorageError =$Error[0].ToString()
echo "storage health"
Invoke-GetHealthStorage
Invoke-GetHealthApplmgmt
echo "health of load"
Invoke-GetHealthLoad -ErrorAction Ignore
Invoke-GetHealthMem
Invoke-GetHealthSoftwarePackages
echo "swap"

Invoke-GetHealthSwap

# Append the error to a log file

echo "system:"
$system = Invoke-GetHealthSystem 2>> "C:\Workspace\FAR\Powershell\vCenter\error.log"
$system
#----------------------------------------
# Reset error action preference to default value
$ErrorActionPreference = "Continue"

$DBError
$DBStorageError




function Get-ApplianceHealth
{
    begin{
     $healthResult =[PSCustomObject]@{
        Database = "Not Available"
        DatabaseStorage = "Not Available"
        Storage = "Not Available"
        Applmgmt = "Not Available"
        Load = "Not Available"
        Memory = "Not Available"
        SoftwarePackages = "Not Available"
        Swap = "Not Available"
        System = "Not Available"
    }
    }
    PROCESS
    {
        Write-Information "get health check for appliance objects ..." -InformationAction Continue  
        # Temporarily change the error action preference
        $ErrorActionPreference = "SilentlyContinue"
        #get health
        $healthResult.Database = Invoke-GetHealthDatabase
        $DBError =$Error[0].ToString()
        $healthResult.DatabaseStorage = Invoke-GetHealthDatabaseStorage
        $DBStorageError = $Error[0].ToString()
        $healthResult.Storage = Invoke-GetHealthStorage
        $StorageError =$Error[0].ToString()
        $healthResult.Applmgmt = Invoke-GetHealthApplmgmt
        $ApplmgmtError =$Error[0].ToString()
        $healthResult.Load =Invoke-GetHealthLoad 
        $LoadError =$Error[0].ToString()
        $healthResult.Memory = Invoke-GetHealthMem
        $MemoryError =$Error[0].ToString()
        $healthResult.SoftwarePackages = Invoke-GetHealthSoftwarePackages
        $SoftwarePackagesError =$Error[0].ToString()
        $healthResult.Swap = Invoke-GetHealthSwap
        $SwapError =$Error[0].ToString()
        $healthResult.System = Invoke-GetHealthSystem
        $SystemError =$Error[0].ToString()
        #write errors
        Write-Verbose -Message "Errors during health check were: $DBError, $DBStorageError, $StorageError, $ApplmgmtError, $loadError, $MemoryError, $SoftwarePackagesError, $SwapError,$SystemError"
        #----------------------------------------
        # Reset error action preference to default value
        $ErrorActionPreference = "Continue"
    }
}
