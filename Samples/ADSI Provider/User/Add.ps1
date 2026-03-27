# -----------------------------------
# PARAMETERS OF SCRIPT YOU MAY MODIFY
# -----------------------------------
# 
# DN of User
	$strUserPath = "CN=Joghn Smith,OU=Samples,DC=oak,DC=msk,DC=qsft"
# DN of Group
	$strGroupName = "CN=Sales Managers,OU=Samples,DC=oak,DC=msk,DC=qsft"


Add-QADGroupMember $strGroupName -member $strUserPath