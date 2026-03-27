Set objUser = GetObject ("EDMS://CN=John Smith,OU=Sales,DC=mydomain,DC=com")
objUser.Put "edsaMoveMailbox", True
objUser.Put "mailNickname", "JSmith"
objUser.Put "edsahomeMDB", "CN=2nd Mailbox Store,CN=First Storage Group,CN=InformationStore,CN=ExchServ,CN=Servers,CN=First Administrative Group,CN=Administrative Groups,CN=First Organization,CN=Microsoft Exchange,CN=Services,CN=Configuration,DC=mydomain,DC=com"
objUser.SetInfo
MsgBox ("Done!")
