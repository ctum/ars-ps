# PARAMETERS OF SCRIPT YOU MAY MODIFY
# -----------------------------------
#
# Before using the script, modify the following constants
$strLocalUser = "EDMS://CN=ServiceUser,CN=Local Users,cn=mycomputer$,cn=mycompany,CN=Network"
$strLocalGroup = "EDMS://cn=Power Users,CN=Local Groups,cn=mycomputer$,cn=mycompany,CN=Network"

# 
# -------------------------------------------------
#
$ADS_PROPERTY_APPEND = 3

$objLocalUser = [ADSI]$strLocalUser
$objLocalGroup = [ADSI]$strLocalGroup

$sid = [byte[]]$objLocalUser.Get("objectSid")
$objlocalGroup.PutEx($ADS_PROPERTY_APPEND, "edsaLocalGroupMembers", $sid)
$objLocalGroup.SetInfo()