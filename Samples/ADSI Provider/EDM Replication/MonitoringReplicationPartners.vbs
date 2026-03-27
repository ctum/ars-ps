const strRGContainerDN= "EDMS://CN=Configuration Databases,CN=Server Configuration,cn=Configuration"
Set oRGContainer=GetObject(strRGContainerDN)

Set oConnect = CreateObject("ADODB.Connection")
oConnect.Provider = "ADsDSOObject"

oConnect.Open "DS Query", "", ""

Set oCommand = CreateObject("ADODB.Command")

Set oCommand.ActiveConnection = oConnect

' Set the search string
oCommand.CommandText = "SELECT edsvaARServices, edsaReplicationRole, edsaErrorMessage, edsaReplicationStatus FROM '" _
                       + strRGContainerDN + "' WHERE objectClass = 'edsReplicationPartner'"

' Set additional properties of the search string
oCommand.Properties("Timeout") = 30 'seconds

' Start the search
Set oRes = oCommand.Execute

strResult=""
Do Until oRes.EOF
  sComp = oRes.Fields("edsvaARServices").Value
  strResult = strResult + "Computer: " + join (sComp, ", ") + vbNewLine
  strResult = strResult + "Replication role: "
  Select Case oRes.Fields("edsaReplicationRole").Value
    Case 1	strResult = strResult + "[Publisher]"
    Case 2	strResult = strResult + "[Subscriber]"
    Case 3	strResult = strResult + "[Standalone]"
    Case Else	strResult = strResult + "[unknown replication role]"
  End Select
  strResult = strResult + "; Replication Status: "
  Select Case oRes.Fields("edsaReplicationStatus").Value
    Case 1  strResult = strResult + "[Start]"
    Case 2  strResult = strResult + "[Succeed]"
    Case 3  strResult = strResult + "[In progress]"
    Case 4  strResult = strResult + "[Idle]"
    Case 5  strResult = strResult + "[Retry]"
    Case 6  strResult = strResult + "[Fail]"
    Case Else	strResult = strResult + "[unknown status]"
  End Select
  strResult = strResult + vbNewLine
  If (VarType(oRes.Fields("edsaErrorMessage").Value) <> vbNull) Then
    strResult = strResult + "Last action message: " + oRes.Fields("edsaErrorMessage").Value
  End If
  strResult = strResult + vbNewLine + "===================================" + vbNewLine
  oRes.MoveNext
Loop

WScript.Echo strResult
