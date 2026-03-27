# -----------------------------------
# PARAMETERS OF SCRIPT YOU MAY MODIFY
# -----------------------------------
# 
#DN of the user to disable
$strUserPath = "CN=Joghn Smith,OU=Samples,DC=oak,DC=msk,DC=qsft"
Enable-QADUser $strUserPath 