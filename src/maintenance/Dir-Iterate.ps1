

# Check if a command line argument was provided
if ($args.Count -gt 0) {
    # Use the provided argument as the directory path
    $directoryPath = $args[0]
}
else {
    # Prompt the user for the directory path
    $directoryPath = Read-Host "Enter the directory path"

    # If no input is provided, use the default value
    if ([string]::IsNullOrWhiteSpace($directoryPath)) {        
        $defaultDirectoryPath = "E:\!_Music"
        Write-Host "`nNo directory path was provided, using script default: `n$defaultDirectoryPath"
        Write-Host ""
        $directoryPath = $defaultDirectoryPath
    }
}

# Check if the provided or entered directory path exists
if (-not (Test-Path -Path $directoryPath -PathType Container)) {
    Write-Host "Directory does not exist: $directoryPath"
    exit
}

# Get a list of subdirectories (folders) in the specified directory
$folders = Get-ChildItem -Path $directoryPath -Directory

# Assign variables
#$folderPrefix = "!_"

# Iterate through each folder
foreach ($folder in $folders) {
    #$folderName = $folder.Name
    #$newFolderName = "$folderPrefix" + $folderName
    #Write-Host "This is the folder variable + FullName"
    $folderFullname = $folder.FullName
    Write-Host "$folderFullname"
    #Write-Host "This is the folderName variable"
    #Write-Host "$folderName"
    #Write-Host " "

    # Check if the folder name already starts with "!_"
#    if (-not $folderName.StartsWith("$folderPrefix")) {
#        # Rename the folder
#        Rename-Item -Path $folder.FullName -NewName $newFolderName

#        Write-Host "Renamed folder '$folderName' to '$newFolderName'"
#    }
#    else {
#        Write-Host "Folder '$folderName' already has the correct format."
#    }
}
