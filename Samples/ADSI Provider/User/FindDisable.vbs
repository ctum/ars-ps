option explicit

' -----------------------------------
' PARAMETERS OF SCRIPT YOU MAY MODIFY
' -----------------------------------

'Set a mask to which the user names must match
const strSearchCondition = "Name = 'T*'"
'DN of the container where the search will start
const strSearchRoot = "EDMS://Ou=SalesNew,DC=mycompany,DC=com"

' -------------------------------------------------
' 
' -------------------------------------------------


Dim oConnect
Dim Command
Dim rs


Set oConnect = CreateObject("ADODB.Connection")
oConnect.Provider = "ADsDSOObject"
oConnect.Open "DS Query", "", ""
Set Command = CreateObject("ADODB.Command")
Set Command.ActiveConnection = oConnect
' Set the search string
Command.CommandText = "SELECT ADsPath FROM '" _
	+ strSearchRoot + "' WHERE objectClass = 'user' AND " + strSearchCondition
Command.Properties("Page Size") = 2
Command.Properties("Timeout") = 30 'seconds
' Start the search
Set rs = Command.Execute
Dim User
' Process the search results
Do Until rs.EOF
	Set User = GetObject(rs.Fields("ADsPath").Value)
        User.Put "edsaAccountIsDisabled", true
	User.SetInfo
	rs.MoveNext
Loop
