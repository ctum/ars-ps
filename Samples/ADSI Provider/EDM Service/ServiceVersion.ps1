 # Set the computer name
$strCompName = "oak"

Connect-QADService -Service $strCompName -Proxy
$objVI = Get-QADObject "CN=Version Information,CN=Server Configuration,CN=Configuration"
$objVI.Item("edsaVersionProductVersion")


