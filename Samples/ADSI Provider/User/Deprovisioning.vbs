' -----------------------------------
' PARAMETERS OF SCRIPT YOU MAY MODIFY
' -----------------------------------
 
'Set path for the user to be deprovisioned
Const strUserPath = "EDMS://CN=JSmith,OU=sales,DC=domain,DC=company,DC=com"
 
 ' Escape reserved characters in the distinguished name
Function EscapeReservedCharacters(ByVal strDN)
 ' This function can be modified, if necessary
  st = Replace(strDN,"/", "\/")
  EscapeReservedCharacters = st
End Function  
  
Const EDS_CONTROL_OBJECT_DN = 11
ss=""
'Bind to the user object
Set User=GetObject(strUserPath)
'Deprovision the user account
User.Put "edsvaDeprovisionType", 1
User.SetInfo
' Retrieve the deprovisioned user DN
strNewDN = User.Control(EDS_CONTROL_OBJECT_DN)
' Escape reserved characters in the distinguished name
strNewDNEscaped = EscapeReservedCharacters(strNewDN)
Set User = Nothing
' Rebind to the deprovisioned user
Set User = GetObject("EDMS://" + strNewDNEscaped )
User.GetInfoEx Array("edsvaDeprovisionStatus","edsvaDeprovisionDeletionDate"),0
'Check the deprovisioning operation status
If User.Get("edsvaDeprovisionStatus") = 1 Then
    ss = ss + "The deprovision operation succeeded." + vbcrlf
    ss = ss + "The new DN of the user is: " + strNewDN + vbcrlf

    On Error Resume Next
        DeletionDate = User.Get("edsvaDeprovisionDeletionDate")
    On Error GoTo 0
    If DeletionDate <> vbEmpty Then
       ss = ss + "The deprovisioned user will be permanently deleted after: " + CStr(DeletionDate) 
    MsgBox ss,vbOk+vbInformation 
                       Else
     MsgBox  "The deprovisioning operation failed. For details, see the deprovisioning results report." ,vbOk+vbCritical
End If
End If
 
 

