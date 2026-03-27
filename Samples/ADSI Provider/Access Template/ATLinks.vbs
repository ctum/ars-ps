 'Set DN of the directory object in question
strObjDN = "CN=DistrGroup,OU=Sales,DC=mydomain,DC=local"

set Obj = GetObject("EDMS://" & strObjDN) 
Set OctetString=CreateObject("AelitaEDM.EDMOctetString")
OctetString.Set Obj.Get("objectGUID")
strFilter = "(edsaSecObjectGUID=" & OctetString.GetGuidString & ")"

Set oConnect = CreateObject("ADODB.Connection")
oConnect.Provider = "ADsDSOObject"    
oConnect.Open "DS Query", "", ""
Set Command = CreateObject("ADODB.Command")
Set Command.ActiveConnection = oConnect
Command.CommandText = "<EDMS://CN=AT Links,CN=Configuration>;" & strFilter & ";edsaAccessTemplateGUID,edsaSecObjectGUID,edsaTrusteeSID;OneLevel"
Set rs = Command.Execute
ss = ""
ss= ss+ "Access Templates that are linked to the object: " + strObjDN + vbNewLine + vbNewLine
 
Do Until rs.EOF
    ss= ss+ "Access Template DN: " & LookupGUID (rs.Fields("edsaAccessTemplateGUID").Value) + vbNewLine
    ss= ss+ "Trustee: " & LookupSID (rs.Fields("edsaTrusteeSID").Value) + vbNewLine
    ss= ss+ "Inherited from: " & LookupGUID (rs.Fields("edsaSecObjectGUID").Value)  + vbNewLine
    ss= ss+ "-------------------------------------------------------------------"  + vbNewLine
    rs.MoveNext
Loop
Wscript.Echo ss
Set rs = Nothing
Set Command = Nothing
Set oConnect = Nothing

 
Function LookupGUID (binGuid)
 ' This function looks up the object by GUID
    
    Set objLookup = CreateObject("EDSILookup")
    objLookup.Initialize2 "", "", "", 0
 
    Set objLookupInfoCollection = objLookup.LookupGUIDs(Array(binGuid))

   For Each objLookupInfo In objLookupInfoCollection
        If objLookupInfo.DN <> "" Then
            LookupGUID = objLookupInfo.DN
                                  Else
            LookupGUID = objLookupInfo.printableName
        END IF
   
   Next
 
    Set objLookup = Nothing
    Set objLookupInfoCollection = Nothing
End Function

Function LookupSID (binSID)    
 ' This function looks up the object by SID
    
   Set objLookup = CreateObject("EDSILookup")
   objLookup.Initialize2 "", "", "", 0
   Set objLookupInfoCollection = objLookup.LookupSIDs(Array(binSID))
               
   For Each objLookupInfo In objLookupInfoCollection
      IF objLookupInfo.DN <> ""  Then
            LookupSID = objLookupInfo.DN
                                 Else
            LookupSID = objLookupInfo.printableName
      END IF    
   Next
   Set objLookup = Nothing
   Set objLookupInfoCollection = Nothing
End Function
