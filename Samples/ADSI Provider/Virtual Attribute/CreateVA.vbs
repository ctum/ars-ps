 ' Set the property attributeSyntax for the VA
const strAttrSyntaxString = "2.5.5.4"
 ' Set the property oMSyntax for the VA
const iAtrrSyntaxOM = 20
 ' Set the property lDAPDisplayName for the VA
const strAttrLdapDispName = "edsvaTestVA"
 ' Set the object class to which the VA will apply
const strAttrClass = "user"
 ' Specify whether to store the VA in the Active Roles configuration database
const bToStore = True
 ' Specify whether the VA is single-valued
const bisSingleValued = True

const strVAContainerDn = "CN=Virtual Attributes,CN=Server Configuration,CN=Configuration"

Sub CreateVA(strAttrName, strClassSchemas, strAttributeSyntax, iOMSyntax, bisStored, bisSingleValued)
	Dim objVaContainer, objNewVa, objOctetString, objPolicyInfoList
	Set objVaContainer=GetObject("EDMS://" + strVAContainerDn)
	Set objOctetString = CreateObject("AelitaEDM.EDMOctetString")
	Wscript.Echo "Creating VA " + strAttrName + "..."
	Set objNewVa=objVaContainer.Create("edsVirtualAttribute", "CN=" + strAttrName)
    set objPolicyInfoList = objNewVa.GetPolicyInfoList()
    objOctetString.SetGuidString(objPolicyInfoList("schemaIDGUID").GeneratedValue)

    objNewVa.Put "edsaAttributeIsStored", CBool(bisStored)
    objNewVa.Put "isSingleValued", CBool(bisSingleValued)
    objNewVa.Put "lDAPDisplayName", strAttrName
    objNewVa.Put "edsaClassSchemas", strClassSchemas
    objNewVa.Put "attributeSyntax", strAttributeSyntax
    objNewVa.Put "oMSyntax", CInt(iOMSyntax)
    objNewVa.Put "schemaIDGUID", objOctetString.GetOctetString()
    objNewVa.Put "attributeID", objPolicyInfoList("attributeID").GeneratedValue

    objNewVa.SetInfo
    Set objNewVa=Nothing
   	Set objOctetString=Nothing
   	Set objVaContainer=Nothing
End Sub

Call CreateVA(strAttrLdapDispName, strAttrClass, strAttrSyntaxString, iAtrrSyntaxOM, bToStore, bisSingleValued)