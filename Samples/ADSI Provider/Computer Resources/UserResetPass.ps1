# PARAMETERS OF SCRIPT YOU MAY MODIFY
# -----------------------------------
#
# Before using the script, modify the following constants
$strLocalUser = "EDMS://CN=Administrator,CN=Local Users,cn=mycomputer$,cn=mycompany,CN=Network"
$strNewPass = "star995polo815"

# -------------------------------------------------
$objLocalUser = [ADSI]$strLocalUser
$objLocalUser.Put("edsaLocalUserPassword", $strNewPass)
$objLocalUser.SetInfo()