option explicit
 ' PARAMETERS OF SCRIPT YOU MAY MODIFY
 ' -----------------------------------
 '
 ' Before using the script, modify the following constants
 '
 ' DN of Policy Object (PO)
const strPolicyObjectDN = "EDMS://CN=TestPO,CN=Administration,CN=Policies,CN=Configuration"

 ' DN of a directory object to which you want to apply the PO
const strObjectToApplyDN = "EDMS://OU=Sales,DC=mycompany,DC=com"

 ' 
 ' -------------------------------------------------
 '
const strAPLinksContainerDN = "EDMS://CN=AP Links,CN=Configuration"

Dim ContainerObject
Set ContainerObject = GetObject(strAPLinksContainerDN)

 ' Construct unique Policy Object link name
Dim APLinkName, OctetString
Set OctetString=CreateObject("AelitaEDM.EDMOctetString")
OctetString.GenerateGuid
APLinkName="CN="+OctetString.GetGuidString

 ' Create policy object link object
Dim poLinkObject
Set poLinkObject = ContainerObject.Create("edsPolicyObjectLink", APLinkName)

 ' Set PO GUID
Dim objPO
Set objPO=GetObject(strPolicyObjectDN)
OctetString.Set objPO.GUID
Set objPO=Nothing
poLinkObject.Put "edsaAPOGUID", OctetString.GetOctetString

 ' Set managed object GUID
Dim objToApply
Set objToApply=GetObject(strObjectToApplyDN)
OctetString.Set objToApply.GUID
Set objToApply=Nothing
poLinkObject.Put "edsaSecObjectGUID", OctetString.GetOctetString

 ' Commit changes
poLinkObject.SetInfo
