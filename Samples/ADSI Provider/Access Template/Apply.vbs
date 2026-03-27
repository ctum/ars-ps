option explicit
 ' PARAMETERS OF SCRIPT YOU MAY MODIFY
 ' -----------------------------------
 '
 ' DN of AT
const strAccessTemplateDN = "EDMS://CN=TestAT,CN=Access Templates,CN=Configuration"

 ' Securable object - entire domain
const strObjectToSecure = "EDMS://DC=mycompany,DC=com"

 ' Trustee object
const strTrusteeObject = "EDMS://CN=Everyone,CN=WellKnown Security Principals,CN=Configuration,DC=mycompany,DC=com"

 ' 
 ' -------------------------------------------------
 '
const strACEsContainerDN = "EDMS://CN=AT Links,CN=Configuration"

Dim ContainerObject, OctetString
Set OctetString=CreateObject("AelitaEDM.EDMOctetString")
Set ContainerObject = GetObject(strACEsContainerDN)

OctetString.GenerateGuid

 'Create AT link object
Dim atLinkObject
Set atLinkObject = ContainerObject.Create("edsACE", "CN=" + CStr(OctetString.GetGuidString) )
Set OctetString=Nothing

atLinkObject.TrusteeADsPath = strTrusteeObject
atLinkObject.AccessTemplateADsPath = strAccessTemplateDN
atLinkObject.SecurableObjectADsPath = strObjectToSecure

atLinkObject.SetInfo
