option explicit

 ' -----------------------------------
 ' PARAMETERS OF SCRIPT YOU MAY MODIFY
 ' -----------------------------------
 ' Before using the script, modify the following constants
 '
 ' Search condition
const strSearchCondition = "Name = 'Sales*'"
 ' DN of the container where the search will start
const strSearchRoot = "EDMS://DC=mycompany,DC=com"
 ' DN of User
const strUserToAdd = "EDMS://CN=Test,OU=Sales,DC=mycompany,DC=com"

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
	+ strSearchRoot + "' WHERE objectClass = 'group' AND " + strSearchCondition

 ' Set additional properties of the search string
Command.Properties("Page Size") = 2
Command.Properties("Timeout") = 30 'seconds

 ' Start the search
Set rs = Command.Execute
Dim groupObject
 ' Process the search results
Do Until rs.EOF
	Set groupObject = GetObject(rs.Fields("ADsPath").Value)
    groupObject.Add strUserToAdd
	groupObject.SetInfo
	Set groupObject=Nothing
	rs.MoveNext
Loop
MsgBox "Done!"
