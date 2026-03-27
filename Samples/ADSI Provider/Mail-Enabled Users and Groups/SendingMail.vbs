 ' Set the DN of the mail-enabled user or group
Const strDN = "CN=TestUser,OU=MyOU,DC=MyCompany,DC=com"

 ' Set the email message text
Const strMsgText  = "Hello, World!"

 ' Set the email subject
Const strSubject = "A test message"
 
  ' Set the Administrator email
Const strMailFrom = "Administrator@mycompany.com"

 ' Set the DNS or NetBIOS name of the host to which to post the message
 ' using the SMTP protocol.
Const strSmtpServer = "smtp.mycompany.com"

 ' Set the port on which the SMTP service is listening
Const intSmtpPort = 25



Sub SendMail(ByVal strMsg, ByVal strSubj, ByVal strMailTo, ByVal strMailFrom )

 ' Specify that the message will be sent using the network
 ' (SMTP over the network).
Const CdoSendUsingPort =2

Set iMsg = CreateObject("CDO.Message")
With iMsg
   .From    = strMailFrom
   .To      = strMailTo
   .Subject = strSubj
End With

Set iBp = iMsg.BodyPart
iBp.ContentMediaType = "multipart/mixed"

Set iBp2 = iBp.AddBodyPart
With iBp2
   .ContentMediaType        = "text/plain"
   .ContentTransferEncoding = "7bit"
   Set Stm = .GetDecodedContentStream
   Stm.WriteText strMsg
   Stm.Flush
End With

' Configure message
Set iConf = CreateObject("CDO.Configuration")
Set Flds = iConf.Fields
Flds("http://schemas.microsoft.com/cdo/configuration/sendusing")  = CdoSendUsingPort
Flds("http://schemas.microsoft.com/cdo/configuration/smtpserver") = strSmtpServer 
Flds("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = intSmtpPort 
Flds.Update
Set iMsg.Configuration = iConf
' Send message
iMsg.Send
End Sub
Set obj = GetObject("EDMS://" + strDN)
on Error Resume Next       
obj.GetInfoEx Array("mail"),0
strMailTo = obj.Get("mail")
If VarType(strMailTo) <> vbEmpty Then
    SendMail strMsgText, strSubject, strMailTo, strMailFrom
    MsgBox "Message sent"
                                 Else
    MsgBox "The user or group is not mail-enabled"
End If    
