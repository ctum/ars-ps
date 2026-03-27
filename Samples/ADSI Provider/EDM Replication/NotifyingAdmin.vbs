' Set the Active Roles Admin's email
Const strMailTo = "ActiveRolesAdmin@mail.mycompany.com"

' Set the system Admin's email
Const strMailFrom = "administrator@mail.mycompany.com"

' Set the DNS or NetBIOS name of the host to which to post the message
' using the SMTP protocol.
Const strSmtpServer = "smtp.mycompany.com"

' Set the port on which the SMTP service is listening
Const intSmtpPort = 25

 '
 ' 
 ' -------------------------------------------------
 '
const strRGContainerDN= "EDMS://CN=Configuration Databases,CN=Server Configuration,cn=Configuration"

 

Set oRGContainer=GetObject(strRGContainerDN)

Set oConnect = CreateObject("ADODB.Connection")
oConnect.Provider = "ADsDSOObject"

oConnect.Open "DS Query", "", ""

Set oCommand = CreateObject("ADODB.Command")

Set oCommand.ActiveConnection = oConnect

' Set the search string
oCommand.CommandText = "SELECT edsvaARServices, edsaReplicationRole, edsaErrorMessage, edsaReplicationStatus FROM '" + strRGContainerDN + "' WHERE objectClass = 'edsReplicationPartner'"

' Set additional properties of the search string
oCommand.Properties("Timeout") = 30 'seconds

' Start the search
Set oRes = oCommand.Execute
strResult=""

' Process the search results
Do Until oRes.EOF
    sComp = oRes.Fields("edsvaARServices").Value
    If oRes.Fields("edsaReplicationStatus").Value = 6 Then
            strResult = strResult + "Computer: " + join (sComp, ", ") + vbNewLine
            strResult = strResult + "Replication role: "
	    Select Case oRes.Fields("edsaReplicationRole").Value
               Case 1 strResult = strResult + "[Publisher]"
               Case 2 strResult = strResult + "[Subscriber]"
               Case 3 strResult = strResult + "[standalone]"
               Case Else strResult = strResult + "[unknown replication role]"
            End Select
	strResult = strResult + vbNewLine + "Replication failed!" + vbNewLine
	
	If (VarType(oRes.Fields("edsaErrorMessage").Value) <> vbNull) Then
            strResult = strResult + "Last action message: " + oRes.Fields("edsaErrorMessage").Value
        End If
        strResult = strResult + vbNewLine + "===============================" + vbNewLine
    End If    
    oRes.MoveNext
Loop

If strResult <> "" Then
    SendMail strResult, "Replication failed!", strMailTo, strMailFrom
End If

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
