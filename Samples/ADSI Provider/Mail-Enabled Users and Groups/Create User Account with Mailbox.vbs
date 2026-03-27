Set objOU = GetObject ("EDMS://OU=Sales,DC=mycompany,DC=com")
Set objUser = objOU.Create("user", "CN=John Smith")
objUser.Put "edsaCreateMsExchMailbox", True
objUser.Put "mailNickname", "JSmith"
objUser.Put "homeMDB", "CN=1st Mailbox Store,CN=First Storage Group,CN=InformationStore,CN=ExchServ,CN=Servers,CN=First Administrative Group,CN=Administrative Groups,CN=First Organization,CN=Microsoft Exchange,CN=Services,CN=Configuration,DC=mycompany,DC=com"
objUser.SetInfo
MsgBox ("Done!")
