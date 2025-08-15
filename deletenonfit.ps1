# Script to delete files in a specific folder that do not have the .fit extension,
# then move remaining .fit files to a "lights" subfolder.
# WARNING: This script will permanently delete files.

# Specify the target folder
$targetFolder = "C:\Astro\seestar\Experiment\allm31\M 31_mosaic_sub"

# --- Step 1: Delete files that do NOT have the .fit extension ---
Write-Host "Starting deletion process for non-.fit files in $targetFolder..."
Get-ChildItem -Path $targetFolder -File | ForEach-Object {
    # Check if the file extension is NOT .fit
    if ($_.Extension -ne ".fit") {
        # Display which file is being deleted
        Write-Host "Deleting: $($_.FullName)"
        # Actually delete the file
        Remove-Item -Path $_.FullName -ErrorAction SilentlyContinue # Suppress errors if a file is locked, etc.
                                                                # Remove 'SilentlyContinue' if you want to see errors.
    }
}
Write-Host "Deletion process finished for non-.fit files in $targetFolder."
Write-Host "---" # Separator

# --- Step 2: Define and create the "lights" subfolder ---
$lightsFolder = Join-Path -Path $targetFolder -ChildPath "lights"

if (-not (Test-Path -Path $lightsFolder)) {
    Write-Host "Creating folder: $lightsFolder"
    New-Item -Path $lightsFolder -ItemType Directory -ErrorAction Stop | Out-Null # Added Out-Null to suppress output of New-Item
} else {
    Write-Host "Folder already exists: $lightsFolder"
}
Write-Host "---" # Separator

# --- Step 3: Copy remaining (.fit) files to the "lights" folder and delete originals ---
Write-Host "Starting process to move .fit files to $lightsFolder..."
Get-ChildItem -Path $targetFolder -File -Filter "*.fit" | ForEach-Object {
    $destinationFile = Join-Path -Path $lightsFolder -ChildPath $_.Name
    Write-Host "Copying $($_.FullName) to $destinationFile"
    Copy-Item -Path $_.FullName -Destination $destinationFile -ErrorAction SilentlyContinue

    # Verify copy before deleting original (optional, but good practice)
    if (Test-Path -Path $destinationFile) {
        Write-Host "Deleting original: $($_.FullName)"
        Remove-Item -Path $_.FullName -ErrorAction SilentlyContinue
    } else {
        Write-Host "ERROR: Could not verify copy of $($_.Name) to $lightsFolder. Original file not deleted."
    }
}

Write-Host "---" # Separator
Write-Host "Process finished. .fit files (if any) should now be in $lightsFolder and removed from $targetFolder."
Write-Host "Non-.fit files have been deleted from $targetFolder."