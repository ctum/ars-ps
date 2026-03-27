# -----------------------------------
# PARAMETERS OF SCRIPT YOU MAY MODIFY
# -----------------------------------
# Before using the script, modify the following constants
 
# DN of Group
$strGroupName = "CN=Sales Managers,OU=Samples,DC=oak,DC=msk,DC=qsft"
# DN of an object to be added to Group
$strNewMemberPath = "CN=Joghn Smith,OU=Samples,DC=oak,DC=msk,DC=qsft"

# -------------------------------------------------

Add-QADGroupMember $strGroupName -member $strNewMemberPath
