Set Group=GetObject("EDMS://CN=MyGroup,OU=Sales,DC=mycompany,DC=com")
 ' List direct members of the group
Result = ""
on error resume next
Group.GetInfoEx Array("edsaMember"),0
arrMembers=Group.GetEx("edsaMember")
If err.Number = 0 then
    on error goto 0
    Result = Result + "Direct members:" + vbCrLf
    For Each Member in arrMembers
	Result=Result + Member + vbCrLf
    Next
End If
 ' List members because of group nesting, if any
on error resume next
Group.GetInfoEx Array("edsaMemberIndirect"),0
arrMembers=Group.GetEx("edsaMemberIndirect")
If Err.Number = 0 Then
    on error goto 0
    Result = Result + vbCrLf + "Members because of group nesting:" + vbCrLf
    For Each Member in arrMembers
	Result=Result + Member + vbCrLf
    Next
End If
on error goto 0
'Show members list
If Result="" then 
    Wscript.Echo "The group has no members"
Else
    Wscript.Echo Result
End If

