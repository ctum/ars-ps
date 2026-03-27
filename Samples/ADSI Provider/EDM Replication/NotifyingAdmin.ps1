# Set the Active Roles Admin's email
$strMailTo = "ActiveRolesAdmin@mail.mycompany.com"

# Set the system Admin's email
$strMailFrom = "administrator@mail.mycompany.com"

# Set the DNS or NetBIOS name of the host to which to post the message
# using the SMTP protocol.
$strSmtpServer = "smtp.mycompany.com"

# Set the port on which the SMTP service is listening
$ intSmtpPort = 25

# -------------------------------------------------
$strRGContainerDN = "EDMS://CN=Configuration Databases,CN=Server Configuration,cn=Configuration"
$strResult = ""
Get-QADObject -SearchRoot $strRGContainerDN -Type 'edsReplicationPartner'  | %{
	$de = $_.DirectoryEntry
    $de.RefreshCache(("edsvaARServices", "edsaReplicationRole", "edsaErrorMessage", "edsaReplicationStatus"))
    $sComp = $de.InvokeGet("edsvaARServices")
    if ($de.InvokeGet("edsaReplicationStatus") -eq 6)
    {
		$strResult += "Computer: " + $de.InvokeGet("edsvaARServices") + "`n"
		$strResult += "Replication role: "
		$strResult += %{
		switch ($de.InvokeGet("edsaReplicationRole")) {
			1 { "[Publisher]" }
			2 { "[Subscriber]" }
			3 { "[Standalone]" }
			default { "[unknown replication role]" }
		}}
		$strResult += "Replication failed!`n"
		if ($de.InvokeGet("edsaErrorMessage") -ne $null)
		{
			$strResult += "Last action message: " + $de.InvokeGet("edsaErrorMessage")
		}
		$strResult += "`n===================================`n"
    }
}

if ($strResult -ne "")
{
    SendMail $strResult, "Replication failed!", $strMailTo, $strMailFrom
}


Function SendMail($strMsg, $strSubj, $strMailTo, $strMailFrom )
{
    $SmtpClient = New-Object "System.Net.Mail.SmtpClient" -ArgumentList ($strSmtpServer)

    $to = New-Object "System.Net.Mail.MailAddress" -ArgumentList ($strMailTo)
    $from = New-Object "System.Net.Mail.MailAddress" -ArgumentList ($strMailFrom)
    $message = New-Object "System.Net.Mail.MailMessage" -ArgumentList ($from, $to)
    $message.Body = $strMsg
    $message.Subject = $strSubj
    $SmtpClient.Send($message)
}

