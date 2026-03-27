 ' Set the VA name
const strAttrName = "edsvaTestVA"

const strVAContainerDn = "CN=Virtual Attributes,CN=Server Configuration,CN=Configuration"
Const ADS_PROPERTY_APPEND = 3

 ' Bind to the VA
Set objVA=GetObject("EDMS://" + "CN="+ strAttrName + "," + strVAContainerDn)
 ' Load into the cashe the VA properties you want to modify
objVa.GetInfoEx Array("edsaClassSchemas","isSingleValued"),0
 ' Modify the VA properties
objVa.PutEx ADS_PROPERTY_APPEND, "edsaClassSchemas", Array("computer","contact")
objVA.Put "isSingleValued",False
 ' Commit changes
objVa.SetInfo
Set objVa=Nothing
MsgBox "The virtual attribute " + strAttrName + " has been modified"
        

