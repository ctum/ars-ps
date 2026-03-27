Set objUser = GetObject ("EDMS://CN=John Smith,OU=Sales,DC=mydomain,DC=com")
objUser.Put "edsaEstablishEmail", True
objUser.Put "mailNickname", "JSmith"
objUser.Put "edsaAdminGroup", "CN=First Administrative Group,CN=Administrative Groups,CN=First Organization,CN=Microsoft Exchange,CN=Services,CN=Configuration,DC=mydomain,DC=com"
objUser.Put "targetAddress", "SMTP:JSmith@email.com"
objUser.SetInfo
MsgBox ("Done!")
