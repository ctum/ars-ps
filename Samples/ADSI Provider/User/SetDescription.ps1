# -------------------------------------------------
# PARAMETERS OF SCRIPT YOU MAY MODIFY
# -----------------------------------

$strUserPath = "CN=Joghn Smith,OU=Samples,DC=oak,DC=msk,DC=qsft"
$strObjDescription = "Database Administrator"

# -------------------------------------------------

Set-QADUser $strUserPath -Description $strObjDescription