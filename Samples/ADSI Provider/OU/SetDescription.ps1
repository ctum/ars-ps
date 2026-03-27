# -------------------------------------------------
# PARAMETERS OF SCRIPT YOU MAY MODIFY
# -----------------------------------
# Before using the script, modify the following constant

$strOUDN = "OU=TestOU,OU=Samples,DC=oak,DC=msk,DC=qsft"
$strNewDescription = "A test OU"

# -------------------------------------------------

Set-QADObject $strOUDN -Description $strNewDescription