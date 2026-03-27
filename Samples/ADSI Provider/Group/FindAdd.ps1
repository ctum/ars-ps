# -----------------------------------
# PARAMETERS OF SCRIPT YOU MAY MODIFY
# -----------------------------------
# Before using the script, modify the following constants

# Search condition
$strSearchCondition = "Sales*"
# DN of the container where the search will start
$strSearchRoot = "OU=Samples,DC=oak,DC=msk,DC=qsft"
# DN of User
$strUserToAdd = "CN=TestUser3,OU=Samples,DC=oak,DC=msk,DC=qsft"

# -------------------------------------------------

Get-QADGroup -name $strSearchCondition -SearchRoot $strSearchRoot | Add-QADGroupMember -member $strUserToAdd 

