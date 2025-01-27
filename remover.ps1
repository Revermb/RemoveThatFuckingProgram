# Ensure the script is run with administrative privileges
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "Please run this script as an Administrator."
    exit
}

# Define the path to search
$path = "C:\"

# Get all items with 'adobe' in their name
$itemsToDelete = Get-ChildItem -Path $path -Recurse -Force -ErrorAction SilentlyContinue | Where-Object { $_.Name -like "*adobe*" }

# Check if any items were found
if ($itemsToDelete.Count -eq 0) {
    Write-Host "No items found with 'adobe' in their name."
}
else {
    # Confirm deletion
    Write-Host "The following items will be deleted:"
    $itemsToDelete | ForEach-Object { Write-Host $_.FullName }

    $confirmation = Read-Host "Are you sure you want to delete these items? (Y/N)"
    if ($confirmation -eq 'Y') {
        # Delete the items
        $itemsToDelete | ForEach-Object {
            try {
                Remove-Item -Path $_.FullName -Recurse -Force -ErrorAction Stop
                Write-Host "Deleted: $($_.FullName)"
            }
            catch {
                Write-Host "Failed to delete: $($_.FullName) - $_"
            }
        }
    }
    else {
        Write-Host "Deletion canceled."
    }
}



# Make sure is: Set-ExecutionPolicy RemoteSigned
# $RemoveThatFuckingShit = Read-Host "What program do you want to delete: ";

#Following code by ChatGPT-4.0 mini
# Define the pattern to search for
# $pattern = "*$RemoveThatFuckingShit*"

# Get the items matching the pattern
# $items = Get-ChildItem -Path C:\ -Recurse -Force -Filter $pattern -ErrorAction SilentlyContinue

# Loop through each item
# foreach ($item in $items) {
# Take ownership
#     $acl = Get-Acl $item.FullName
#     $identity = [System.Security.Principal.WindowsIdentity]::GetCurrent()
#     $acl.SetOwner($identity)
#     Set-Acl -Path $item.FullName -AclObject $acl

# Grant full control to the user 'remiv'
#    $acl = Get-Acl $item.FullName
#  $rule = New-Object System.Security.AccessControl.FileSystemAccessRule("remiv", "FullControl", "Allow")
# $acl.SetAccessRule($rule)
# Set-Acl -Path $item.FullName -AclObject $acl

# Remove the item
# Remove-Item -Path $item.FullName -Recurse -Force -ErrorAction SilentlyContinue
# }
