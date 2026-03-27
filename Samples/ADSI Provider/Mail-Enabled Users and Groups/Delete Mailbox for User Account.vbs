Set objUser = GetObject ("EDMS://CN=John Smith,OU=Sales,DC=mydomain,DC=com")
objUser.Put "edsaDeleteMailbox", True
objUser.SetInfo
MsgBox ("Done!")
