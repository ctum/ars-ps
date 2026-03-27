Set objUser = GetObject("EDMS://cn=Young\, David,ou=Sales,dc=mycompany,dc=com")
ss="The user is a member of the following groups:" + vbCrLf + vbCrLf
 ' List groups to which the user belongs directly.
objUser.GetInfoEx Array("edsaMemberOf"),0
arrMemberOf = objUser.GetEx("edsaMemberOf")
For Each Group in arrMemberOf
    ss = ss + Group + vbCrLf  
Next
 ' List groups to which the user belongs because of group nesting, if any.
On Error Resume Next
If Err.Number = 0 Then
    objUser.GetInfoEx Array("edsaMemberOfIndirect"),0
    arrMemberOf = objUser.GetEx("edsaMemberOfIndirect")
    For Each Group in arrMemberOf
        ss = ss + Group + vbCrLf  
    Next
End If    
Wscript.echo ss
