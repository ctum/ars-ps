 ' Set the computer name
const strCompName = "DC0"
 ' Set the user's login used to connect to the remote computer
const strLogin = "Administrator"
 ' Set the user's password
const strPassw ="secret"

Const ADS_EDMSERVER_BIND = 32768
Set openDS = GetObject("EDMS:")
Set objVI = openDS.OpenDSObject("EDMS://" + strCompName + "/CN=Version Information,CN=Server Configuration,CN=Configuration",strLogin,strPassw, _
    ADS_EDMSERVER_BIND)
objVI.GetInfoEx Array("edsaVersionProductVersion"), 0
strVersion = objVI.Get("edsaVersionProductVersion")
Set objVI=Nothing
Dim lngVersions(3), strVersions, i
strVersions=Split(strVersion, ".", -1, 1)
For i=0 to 3
    lngVersions(i)=CLng(strVersions(i))
Next
MsgBox "Administration Service " + CStr(lngVersions(0)) + "." + CStr(lngVersions(1)) + "." + CStr(lngVersions(2)) + "." + CStr(lngVersions(3)) + " is running "_
       + "on the computer " + strCompName
