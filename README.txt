DirBuster - PowerShell Script

Overview

This PowerShell script streamlines the process of deleting directories. It reads folder paths from an input file (folders_to_delete.txt), deletes the directories, logs the deletions to an output file (deletion_log.txt), and cleans up the input file after processing. The script includes error handling with retry logic to manage transient issues during deletion.

How It Works

The script operates by:

    Checking for the presence of folders_to_delete.txt, which lists the full paths of folders to delete.
    Reading the list and deleting each folder with a retry mechanism for transient errors.
    Logging each deletion or error occurrence to deletion_log.txt, including a timestamp for auditing.
    Cleaning up folders_to_delete.txt by removing the paths of successfully deleted folders.
    Retrying the deletion up to three times if an error is encountered, with a delay between retries.

Prerequisites

    PowerShell installed on your system.
    Administrative privileges for directory deletion.
    folders_to_delete.txt file with the full paths of the directories to be deleted.

Usage

    Ensure folders_to_delete.txt contains the full paths of directories to delete.
    Run the script via "Run with PowerShell" or from the PowerShell command line.
    Review deletion_log.txt for a log of the actions taken by the script.

Features

    Robust Error Handling: The script can handle and log various errors during the deletion process.
    Retry Logic: Transient errors will trigger up to three retry attempts with a 5-second delay between each retry.
    Auditing: All deletions and errors are logged with timestamps.
    Clean-up: The input file is automatically cleaned to only include folders that were not deleted, due to either an error or because they did not exist.

Warning

This script will irreversibly delete the folders listed in folders_to_delete.txt. Ensure you have backups of any important data and verify the folder paths before running the script.
Customization

    Adjust the $maxRetries and $retryDelay variables to change the number of retry attempts and the delay between them.
    Change the paths for the input and log files as needed.