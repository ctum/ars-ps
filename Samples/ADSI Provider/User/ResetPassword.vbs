option explicit

 ' -----------------------------------
 ' PARAMETERS OF SCRIPT YOU MAY MODIFY
 ' -----------------------------------

 ' DN of User
const strUserPath = "EDMS://CN=TestUser,OU=Sales,DC=mycompany,DC=com"
 ' New password
const strNewPass = "1111"

 ' -------------------------------------------------
 ' 
 ' -------------------------------------------------

Dim User
 ' Bind to User
Set User=GetObject(strUserPath)

 ' Set new password
User.Put "edsaPassword", strNewPass
 ' Commit changes
User.SetInfo
