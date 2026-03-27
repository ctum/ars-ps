
# -----------------------------------
# PARAMETERS OF SCRIPT YOU MAY MODIFY
# -----------------------------------

#Set path to the user to be deprovisioned
$strUserPath = "EDMS://CN=Samuel Smith,OU=SalesDept,DC=mycompany,DC=com"

# -------------------------------------------------
# 
# -------------------------------------------------
$ss = ""
#Bind to the user object
$User = [ADSI]$strUserPath
#Deprovision the user account
$User.Put("edsvaDeprovisionType", 1)
$no = $USer.NativeObject
$User.SetInfo()
# Retrieve the deprovisioned user DN
$strNewDNEscaped = $no.ADsPath
$User = $null
# Rebind to the deprovisioned user
$User = [ADSI]"$strNewDNEscaped"
$User.GetInfoEx(("edsvaDeprovisionStatus","edsvaDeprovisionDeletionDate"),0)

#On Error Resume Next
#Check the deprovisioning operation status
if ($User.InvokeGet("edsvaDeprovisionStatus") -eq 1)
{
    $ss += "The deprosion operation succeeded.`n"
    $strNewDN = $User.distinguishedName
    $ss += "The new DN of the user is: $strNewDN`n"
    $DeletionDate = $User.InvokeGet("edsvaDeprovisionDeletionDate")
    if ($DeletionDate -ne $null)
    {
       $ss += "The deprovisioned user will be permanently deleted after: $DeletionDate"
    }
    $ss
}    
else
{
    "The deprovisioning operation failed. For details, see the deprovisioning results report."
}    


