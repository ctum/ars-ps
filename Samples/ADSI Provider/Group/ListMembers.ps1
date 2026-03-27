

$groupDN = "CN=SalesStuff,OU=Samples,DC=oak,DC=msk,DC=qsft"

$group = Get-QADGroup $groupDN
# List direct members of the group
$group.Member
# List members because of group nesting, if any
$group.NestedMembers 

