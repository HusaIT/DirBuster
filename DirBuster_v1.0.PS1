# Input file containing the list of folders to delete
$inputFilePath = "folders_to_delete.txt"

# Output log file to record the deletions
$logFilePath = "deletion_log.txt"

# Maximum number of retries for deletion
$maxRetries = 3

# Delay between retries in seconds
$retryDelay = 5

# Get the current timestamp
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

# Check if the input file exists
if (Test-Path $inputFilePath) {
    # Read the folder paths from the input file
    $folders = Get-Content $inputFilePath

    # Initialize an array to hold folders that could not be deleted
    $foldersNotDeleted = @()

    # Loop through each folder and attempt to delete it
    foreach ($folder in $folders) {
        $retryCount = 0

        # Keep trying to delete until the maximum number of retries is reached
        while ($retryCount -lt $maxRetries) {
            try {
                if (Test-Path $folder) {
                    Write-Host "Attempting to delete $folder..."
                    Remove-Item $folder -Recurse -Force -ErrorAction Stop
                    Write-Host "$folder deleted."
                    "${timestamp}: $folder deleted" | Out-File $logFilePath -Append
                    break # Exit the retry loop on success
                } else {
                    Write-Host "Folder $folder does not exist."
                    "${timestamp}: Folder $folder does not exist." | Out-File $logFilePath -Append
                    break # Exit the retry loop
                }
            } catch {
                $retryCount++
                Write-Host "Error deleting $folder. Attempt $retryCount of $maxRetries."
                "${timestamp}: Error deleting $folder. Attempt $retryCount of $maxRetries." | Out-File $logFilePath -Append

                if ($retryCount -ge $maxRetries) {
                    Write-Host "Failed to delete $folder after $maxRetries attempts."
                    "${timestamp}: Failed to delete $folder after $maxRetries attempts." | Out-File $logFilePath -Append
                    $foldersNotDeleted += $folder
                    break # Exit the retry loop on final failure
                } else {
                    Start-Sleep -Seconds $retryDelay
                }
            }
        }
    }

    # Rewrite the input file excluding the deleted folders
    $foldersNotDeleted | Out-File $inputFilePath
} else {
    Write-Host "Input file $inputFilePath not found."
    "${timestamp}: Input file $inputFilePath not found." | Out-File $logFilePath -Append
}
