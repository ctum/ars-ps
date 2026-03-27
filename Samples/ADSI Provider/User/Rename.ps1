# -----------------------------------
# PARAMETERS OF SCRIPT YOU MAY MODIFY
# -----------------------------------

$strOldUserName = "CN=TestUser,OU=Samples,DC=oak,DC=msk,DC=qsft"
$strNewUserName = "TestUser3"

# -------------------------------------------------

Rename-QADObject $strOldUserName -NewName $strNewUserName
