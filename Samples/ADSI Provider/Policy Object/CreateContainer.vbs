option explicit
 ' PARAMETERS OF SCRIPT YOU MAY MODIFY
 ' -----------------------------------
 '
 ' Before using the script, modify the following constants
 '
 ' Name of PO Container to create
const strContainerName= "CN=Restrict Policies"
 ' -------------------------------------------------
 '
Dim ParentContainer, rootDSE, contDN
' Bind to the rootDSE
Set rootDSE = GetObject("EDMS://rootDSE")
rootDSE.GetInfoEx Array("edsvaAdministrationPoliciesDN"),0
' Get DN of the container for Policy Objects
contDN = rootDSE.Get("edsvaAdministrationPoliciesDN")
Set ParentContainer=GetObject("EDMS://" & contDN)

Dim poContainerObject
Set poContainerObject = ParentContainer.Create("edsPolicyObjectsContainer", strContainerName)
poContainerObject.SetInfo
