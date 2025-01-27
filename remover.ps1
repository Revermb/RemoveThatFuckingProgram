# Make sure is: Set-ExecutionPolicy RemoteSigned;
$RemoveThatFuckingShit = Read-Host "What program do you want to delete: ";

# Define the pattern to search for
$pattern = "*$RemoveThatFuckingShit*"

# Get the items matching the pattern
$items = Get-ChildItem -Path C:\ -Recurse -Force -Filter $pattern -ErrorAction SilentlyContinue

# Loop through each item
foreach ($item in $items) {
    # Take ownership
    $acl = Get-Acl $item.FullName
    $identity = [System.Security.Principal.WindowsIdentity]::GetCurrent()
    $acl.SetOwner($identity)
    Set-Acl -Path $item.FullName -AclObject $acl

    # Grant full control to the user 'remiv'
    $acl = Get-Acl $item.FullName
    $rule = New-Object System.Security.AccessControl.FileSystemAccessRule("remiv", "FullControl", "Allow")
    $acl.SetAccessRule($rule)
    Set-Acl -Path $item.FullName -AclObject $acl

    # Remove the item
    Remove-Item -Path $item.FullName -Recurse -Force -ErrorAction SilentlyContinue
}
