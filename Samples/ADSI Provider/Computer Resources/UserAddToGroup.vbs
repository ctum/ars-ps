option explicit
 ' PARAMETERS OF SCRIPT YOU MAY MODIFY
 ' -----------------------------------
 '
 ' Before using the script, modify the following constants
const strLocalUser = "EDMS://CN=ServiceUser,CN=Local Users,cn=mycomputer$,cn=mycompany,CN=Network"
const strLocalGroup = "EDMS://cn=Power Users,CN=Local Groups,cn=mycomputer$,cn=mycompany,CN=Network"

 ' 
 ' -------------------------------------------------
 '
const ADS_PROPERTY_APPEND = 3

Dim objLocalGroup, objLocalUser, objOctetString

Set objOctetString = CreateObject("AelitaEDM.EDMOctetString")
Set objLocalUser=GetObject(strLocalUser)

objOctetString.Set objLocalUser.Get("objectSID")
Set objLocalUser=Nothing

Set objLocalGroup=GetObject(strLocalGroup)
objLocalGroup.PutEx ADS_PROPERTY_APPEND, "edsaLocalGroupMembers", objOctetString.GetOctetString
objLocalGroup.SetInfo
