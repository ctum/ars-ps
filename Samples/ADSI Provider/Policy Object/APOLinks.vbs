 ' Set DN of the directory object in question.
const strObjDN = "EDMS://CN=DistrGroup,OU=Sales,DC=mycompany,DC=com"

set Obj = GetObject(strObjDN) 
objGuid = Obj.Get("objectGUID")
Set OctetString=CreateObject("AelitaEDM.EDMOctetString")
OctetString.Set objGuid 
strFilter = "(edsaSecObjectGUID=" & OctetString.GetGuidString & ")"
Set oConnect = CreateObject("ADODB.Connection")
oConnect.Provider = "ADsDSOObject"    
oConnect.Open "DS Query", "", ""
Set Command = CreateObject("ADODB.Command")
Set Command.ActiveConnection = oConnect
Command.CommandText = "<EDMS://CN=AP Links,CN=Configuration>;" & strFilter & ";edsaAPOGUID,edsaSecObjectGUID;OneLevel"
Set rs = Command.Execute    
ss = "Policy Objects that are linked to the object " + strObjDN + vbNewLine + vbNewLine
ss = ss + vbNewLine
Do Until rs.EOF
    ss = ss + "Policy Object DN: "
    ss = ss + LookupGUID(rs.Fields("edsaAPOGUID").Value) + vbNewLine
    ss = ss + "Inherited from: "
    ss = ss + LookupGUID(rs.Fields("edsaSecObjectGUID").Value) + vbNewLine
    ss = ss + "----------------------------------------------------" + vbNewLine
    rs.MoveNext
Loop
Set rs = Nothing
Set Command = Nothing
Set oConnect = Nothing
Wscript.Echo ss

 '====================================================
Function LookupGUID (binGuid)
 ' This function looks up the object by GUID
    
    Set objLookup = CreateObject("EDSILookup")
    objLookup.Initialize2 "", "", "", 0
 
    Set objLookupInfoCollection = objLookup.LookupGUIDs(Array(binGuid))

   For Each objLookupInfo In objLookupInfoCollection
        IF objLookupInfo.DN <> "" Then
            LookupGUID = objLookupInfo.DN
                                  Else
            LookupGUID = objLookupInfo.printableName
        END IF
   
   Next
 
    Set objLookup = Nothing
    Set objLookupInfoCollection = Nothing
End Function
