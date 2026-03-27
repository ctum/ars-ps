option explicit

' -----------------------------------
' PARAMETERS OF SCRIPT YOU MAY MODIFY
' -----------------------------------

'Path to user to enable
const strUserPath = "EDMS://CN=TestUser,DC=mycompany,DC=com"

' -------------------------------------------------
' 
' -------------------------------------------------

Dim User
'Get the user object
Set User=GetObject(strUserPath)

'Disable user account
User.Put "edsaAccountIsDisabled", false

'Commit changes
User.SetInfo

'Perform some cleanup
Set User=Nothing
