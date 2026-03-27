 ' -----------------------------------
 ' PARAMETERS OF SCRIPT YOU MAY MODIFY
 ' -----------------------------------
 ' Before using the script, modify the following constants
 '
 ' Set the DN of Managed Unit
 const strMU = "CN=MyMU,CN=Managed Units,cn=Configuration"
 ' Set the output file name
 const strOutputFile = "C:\temp\userlist.txt"
 '
 ' 
 ' -------------------------------------------------
 '
 Set fso = CreateObject("Scripting.FileSystemObject")
 Set NewFile = fso.CreateTextFile(strOutputFile, True)
 Set oConnect = CreateObject("ADODB.Connection")
 oConnect.Provider = "ADsDSOObject"
 oConnect.Open "DS Query", "", ""
 Set Command = CreateObject("ADODB.Command")
 Set Command.ActiveConnection = oConnect
  ' Specify the search criteria
 Command.CommandText = _
 "<EDMS://" + strMU + "//EDS_SEARCHPREF_ATTRIBUTE_QUERY=edsaMember>;(objectClass=user);distinguishedName;base"
 NewFile.WriteLine "Managed Unit: " + strMU + " includes the following users: "
 NewFile.WriteLine ""
 Set rs = Command.Execute
 Do Until rs.EOF
     NewFile.WriteLine "DN: " + rs.Fields("distinguishedName").Value
     rs.MoveNext
 Loop
 NewFile.Close
 Set fso=nothing
 Set NewFile=nothing
 MsgBox "The file " + strOutputFile + " was created."
 