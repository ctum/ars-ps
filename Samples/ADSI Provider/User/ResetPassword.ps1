# -----------------------------------
# PARAMETERS OF SCRIPT YOU MAY MODIFY
# -----------------------------------

# DN of User
$strUserPath = "CN=Joghn Smith,OU=Samples,DC=oak,DC=msk,DC=qsft"
# New password
$strNewPass = "P@ssword"

# -------------------------------------------------

Set-QADUser $strUserPath -UserPassword $strNewPass
