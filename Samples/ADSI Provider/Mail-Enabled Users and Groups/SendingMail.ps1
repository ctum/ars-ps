# Set the DN of the mail-enabled user or group
$Dn = "CN=TestUser,OU=MyOU,DC=MyCompany,DC=com"

# Set the email message text
$MsgText  = "Hello, World!"

# Set the email subject
$Subject = "A test message"
 
# Set the Administrator email
$MailFrom = "Administrator@mycompany.com"

# Set the DNS or NetBIOS name of the host to which to post the message
# using the SMTP protocol.
$SmtpServer = "smtp.mycompany.com"

# Set the port on which the SMTP service is listening
$SmtpPort = 25

function SendMail($Message, $Subject, $MailTo, $MailFrom)
{
	# Specify that the message will be sent using the network
	# (SMTP over the network).
	$CdoSendUsingPort = 2
	
	$Msg = New-Object -ComObject "CDO.Message"
	$Msg.From = $MailFrom
	$Msg.To = $MailTo
	$Msg.Subject = $Subject
	
	$BodyPart = $Msg.BodyPart
	$BodyPart.ContentMediaType = "multipart/mixed"
	
	$BodyPart2 = $BodyPart.AddBodyPart()
	$BodyPart2.ContentMediaType = "text/plain"
	$BodyPart2.ContentTransferEncoding = "7bit"
	
	$Stream = $BodyPart2.GetDecodedContentStream()
	$Stream.WriteText($Message)
	$Stream.Flush()

	# Configure message
	$Configuration = New-Object -ComObject "CDO.Configuration"
	$Msg.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/sendusing") = $CdoSendUsingPort
	$Msg.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpserver") = $SmtpServer 
	$Msg.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = $SmtpPort 
	$Msg.Configuration.Fields.Update()

	# Send message
	$Msg.Send()
}

$User = Get-QADUser "EDMS://$Dn"
if($User -ne $null)
{
	$MailTo = $User.Item("mail")
	if($MailTo -ne $null)
	{
		SendMail -Message $MsgText -Subject $Subject -MailTo $MailTo -MailFrom $MailFrom
	    "Message sent"
	}
	else
	{
		"The user or group is not mail-enabled"
	}
}
else
{
	"User not found `'$Dn`'"
}