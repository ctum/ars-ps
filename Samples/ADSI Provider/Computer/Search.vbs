option explicit

 ' -----------------------------------
 ' PARAMETERS OF SCRIPT YOU MAY MODIFY
 ' -----------------------------------

 ' Set a mask to which the computers names must match
const strSearchCondition = "Name = 'Demo*'"
 ' DN of the container where the search will start
const strSearchRoot = "EDMS://DC=mycompany,DC=com"

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
	+ strSearchRoot + "' WHERE objectClass = 'computer' AND " + strSearchCondition

 ' Set additional properties of the search string
Command.Properties("Page Size") = 2
Command.Properties("Timeout") = 30 'seconds

 ' Start the search
Set rs = Command.Execute
Dim Result
Result=""
 ' Process the search results
Do Until rs.EOF
   	Result=Result+rs.Fields("ADsPath").Value + vbNewLine
	rs.MoveNext
Loop

WScript.Echo Result
