option explicit

' -------------------------------------------------
' PARAMETERS OF SCRIPT YOU MAY MODIFY
' -----------------------------------

const strUserPath = "EDMS://CN=TestUser,DC=mycompany,DC=com"
const strObjDescription = "Database Administrator"

' -------------------------------------------------
' 
' -------------------------------------------------

Dim User
Set User=GetObject(strUserPath)
User.Put "description", strObjDescription
User.SetInfo
