Set objUser = GetObject ("EDMS://CN=John Smith,OU=Sales,DC=mycompany,DC=com ")
objUser.Put "edsva-MsExch-ConvertToLinkedMailbox", True
objUser.Put "edsva-msExch-LinkedMasterAccountDN", "CN=John Smith Shadow Copy,OU=Sales,DC=shadowDomain,DC=com"
objUser.SetInfo
MsgBox ("Done!")
