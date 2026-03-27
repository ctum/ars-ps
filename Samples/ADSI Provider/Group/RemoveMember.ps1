# -----------------------------------
# PARAMETERS OF SCRIPT YOU MAY MODIFY
# -----------------------------------
# Before using the script, modify the following constants

# DN of Group
$strGroupName = "CN=Sales Managers,OU=Samples,DC=oak,DC=msk,DC=qsft"
# DN of the Group member you want to remove
$strMemberPath = "CN=Joghn Smith,OU=Samples,DC=oak,DC=msk,DC=qsft"

# -------------------------------------------------
  
Remove-QADGroupMember $strGroupName -member $strMemberPath 

