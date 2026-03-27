# Set the VA name
$strAttrName = "edsvaTestVA"

$strVAContainerDn = "CN=Virtual Attributes,CN=Server Configuration,CN=Configuration"
$ADS_PROPERTY_APPEND = 3

# Bind to the VA
$objVA = [ADSI]"EDMS://CN=$strAttrName,$strVAContainerDn"
# Modify the VA properties
$objVa.PutEx($ADS_PROPERTY_APPEND, "edsaClassSchemas", ("computer","contact"))
$objVA.Put("isSingleValued", $false)
# Commit changes
$objVa.SetInfo()
"The virtual attribute $strAttrName has been modified"