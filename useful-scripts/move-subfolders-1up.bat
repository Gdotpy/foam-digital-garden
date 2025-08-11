#Batch Script to move all subfolder files, 1 level higher
# Set the parent folder path here
$parentFolder = "D:\Imagenes\DCIM"

# Get all immediate subfolders
$subfolders = Get-ChildItem -Path $parentFolder -Directory

foreach ($folder in $subfolders) {
    # Get all files in the subfolder (not recursively)
    $files = Get-ChildItem -Path $folder.FullName -File

    foreach ($file in $files) {
        $destinationPath = Join-Path -Path $parentFolder -ChildPath $file.Name

        # If a file with the same name exists in the parent, rename the one being moved
        if (Test-Path -Path $destinationPath) {
            $timestamp = Get-Date -Format "yyyyMMddHHmmss"
            $newName = "$($file.BaseName)_$timestamp$($file.Extension)"
            $destinationPath = Join-Path -Path $parentFolder -ChildPath $newName
        }

        # Move the file
        Move-Item -Path $file.FullName -Destination $destinationPath
    }

    # Optional: Remove the subfolder if it's empty
    # Remove-Item -Path $folder.FullName -Force -Recurse
}


