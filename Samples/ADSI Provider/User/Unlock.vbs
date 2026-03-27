option explicit

' Path to the user to unlock
const strUserPath = "EDMS://CN=TestUser,DC=mycompany,DC=com"

Dim User
' Bind to the user object
Set User=GetObject(strUserPath)

' Unlock user account
User.Put "lockoutTime", 0

' Commit changes
User.SetInfo
Set User=Nothing
