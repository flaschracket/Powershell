# Check if the script is running with administrative privileges
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "Please run this script as an administrator."
    Exit 1
}

# Search for and install Windows updates
Write-Host "Searching for available updates..."
$Session = New-Object -ComObject "Microsoft.Update.Session"
$Searcher = $Session.CreateUpdateSearcher()
$Criteria = "IsInstalled=0"
$SearchResult = $Searcher.Search($Criteria)

if ($SearchResult.Updates.Count -eq 0)
{
    Write-Host "No updates found."
    Exit 0
}

Write-Host "Found $($SearchResult.Updates.Count) update(s)."

# Download and install updates
$Downloader = $Session.CreateUpdateDownloader()
$Downloader.Updates = $SearchResult.Updates
$Downloader.Download()

$Installer = New-Object -ComObject "Microsoft.Update.Installer"
$Installer.Updates = $SearchResult.Updates
$InstallationResult = $Installer.Install()

# Check installation result
if ($InstallationResult.RebootRequired) {
    Write-Host "Updates installed successfully. Reboot required."
} else {
    Write-Host "Updates installed successfully. No reboot required."
}
