
$User = "CN=Joghn Smith,OU=Samples,DC=oak,DC=msk,DC=qsft"


Write-Host "The user is a member of the following groups:"
# List groups to which the user belongs directly.
Get-QADGroup -ContainsMember $User

# List groups to which the user belongs because of group nesting, if any.
Get-QADGroup -ContainsIndirectMember $User