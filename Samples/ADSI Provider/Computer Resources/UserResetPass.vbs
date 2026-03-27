option explicit
 ' PARAMETERS OF SCRIPT YOU MAY MODIFY
 ' -----------------------------------
 '
 ' Before using the script, modify the following constants
const strLocalUser = "EDMS://CN=Administrator,CN=Local Users,cn=mycomputer$,cn=mycompany,CN=Network"
const strNewPass = "star995polo815"

 ' 
 ' -------------------------------------------------
 '
Dim objLocalUser
Set objLocalUser=GetObject(strLocalUser)
objLocalUser.Put "edsaLocalUserPassword", strNewPass
objLocalUser.SetInfo