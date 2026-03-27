# -------------------------------------------------
# PARAMETERS OF SCRIPT YOU MAY MODIFY
# ------------------------------------------------------------

# Before using the script, modify the following constant
$strGroupDN = "CN=SalesStuff,OU=Samples,DC=oak,DC=msk,DC=qsft"
$strNewDescription = "A test group"

Set-QADGroup $strGroupDN -Description $strNewDescription