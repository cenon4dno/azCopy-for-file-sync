Write-Output 'Start Application'
. ".\powershell\blob.ps1"

# Variable Declaration
$date = Get-Date -UFormat "%Y-%m-%d"
$datetime = Get-Date
# File share config
$shareDirectory = 'share/'
# Log config
$logDirectory = 'logs/'
# log files
$run = 'run-'
$fileurl = 'fileurl-'
$history = 'history'

# Sync Files
$command="azcopy sync '$shareDirectory' '$blobStorageLink$blobStorageDelimiter$blobStorageSAS'"
Invoke-Expression -Command $command | Add-Content -Path "$($logDirectory)$($run)$($date).log"

# Write to fileurl
Out-File -FilePath "$($logDirectory)$($fileurl)$($date).log"
Get-ChildItem $shareDirectory -recurse | ForEach-Object {
     $file = $_.Name
     Write-Output "$blobStorageLink/$file$blobStorageDelimiter$blobStorageSAS" | Add-Content -Path "$($logDirectory)$($fileurl)$($date).log"
}

# Write to history
Write-Output "$datetime Synced '$shareDirectory' directory" | Add-Content -Path "$($logDirectory)$($history).log"

Write-Output 'End Application'