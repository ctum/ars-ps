option explicit

' -----------------------------------
' PARAMETERS OF SCRIPT YOU MAY MODIFY
' -----------------------------------

'DN of the user to disable
const strUserPath = "EDMS://CN=TestUser,DC=mycompany,DC=com"

' -------------------------------------------------
' 
' -------------------------------------------------

Dim User
'Bind to the user object
Set User=GetObject(strUserPath)

'Disable user account
User.Put "edsaAccountIsDisabled", true

'Commit changes
User.SetInfo
