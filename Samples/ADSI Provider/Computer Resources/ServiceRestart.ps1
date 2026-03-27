# PARAMETERS OF SCRIPT YOU MAY MODIFY
# -----------------------------------
#
# Before using the script, modify the following constants
$strServiceDN = "EDMS://cn=Messenger,CN=Services,cn=oakars65$,cn=oak,CN=Network"

# -------------------------------------------------

$SERVICE_STOPPED = 0x01

$ServiceObject = [ADSI]$strServiceDN 
$ServiceObject.edsaStopService = $true
$ServiceObject.CommitChanges()

while ($ServiceObject.edsaServiceStatus -ne $SERVICE_STOPPED) 
{
  sleep 1
  $ServiceObject.RefreshCache()
}
#$ServiceObject.edsaStopService = $false

$ServiceObject.edsaStartService = $true
$ServiceObject.CommitChanges()
