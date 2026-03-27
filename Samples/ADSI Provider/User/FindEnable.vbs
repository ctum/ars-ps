option explicit

' -----------------------------------
' PARAMETERS OF SCRIPT YOU MAY MODIFY
' -----------------------------------

'User search condition
const strSearchCondition = "Name = 'Test*'"
'Root container to start search from
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

' Set command text
Command.CommandText = "SELECT ADsPath FROM '" _
	+ strSearchRoot + "' WHERE objectClass = 'user' AND " + strSearchCondition

' Set additional properties of the search string
Command.Properties("Page Size") = 2
Command.Properties("Timeout") = 30 'seconds

' Start the search
Set rs = Command.Execute
Dim User
' Process the search results
Do Until rs.EOF
	Set User = GetObject(rs.Fields("ADsPath").Value)
    User.Put "edsaAccountIsDisabled", false
	User.SetInfo
	rs.MoveNext
Loop
