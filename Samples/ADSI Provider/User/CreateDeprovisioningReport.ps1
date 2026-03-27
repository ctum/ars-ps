 # -------------------------------------------------
 # PARAMETERS OF SCRIPT YOU MAY MODIFY
 # -------------------------------------------------
 #
 # Before using the script, modify the following constants
 #
 # Set the distinguished name of a deprovisioned user for which you want to create the deprovisioning results report
$strUserAccountDN          = "CN=Samuel Smith - Deprovisioned 9\/28\/2007,OU=Sales,DC=mycompany,DC=com"
 
 # -------------------------------------------------
 # 
 # -------------------------------------------------
 #
 # The script title
 $strScriptTitle            = "Creating Deprovisioning Results Report"
 
 # File name for the deprovisioning results report
 # The first part of the file name
$strDPResultsFileNameStart = "Deprovisioning Results - "
 # The file name extension
$strDPResultsFileNameEnd   = ".htm"

 # The user object attribute where the XML format report is saved
$strDPResultsAttrName      = "edsvaDeprovisionReportXML"
 
 # The user object attribute used to generate the report file name
$strAttrToGetObjName       = "name"

 # The Active Roles provider name
$strBindPrefix             = "EDMS://"
 
 # Silent mode
$bSilentMode               = $false

 # Output a message
function ReportMessage($strInfo, $strMode)
{
  if ($strMode -eq "Error")
  {
      Write-Error "($strScriptTitle) $strInfo"
  }
  Else
  {
      Write-Output "($strScriptTitle) $strInfo"
  }
#  "[$strScriptTitle] $strInfo"
}

 # Bind to the specified directory object
Function BindToObject($strDN)
{
    $dn = $strBindPrefix + $strDN
	$entry = [ADSI]$dn
	if ($entry.path -ne $null)
	{
		return $entry
	}
    ReportMessage "Cannot bind to '$strDN'" ,"Error" 
}

 # Get the specified attribute value
Function GetAttributeValue($obj, $strDN, $strAttrName)
{
    return $obj.Get($strAttrName)
    ReportMessage "Failed to retrieve the attribute '$strAttrName' from object '$strDN'", "Error"
}

 # Get the specified attribute value
Function ReadObjectAttribute($strDN, $strAttrName)
{
    $object = BindToObject $strDN
    $object.GetInfoEx(($strAttrName), 0)
    #GetAttributeValue(object, strDN, strAttrName)
    $object.InvokeGet($strAttrName)
    $object = $null
}


 # Generate the output file name
Function GetOutputFileName($strObjectName)
{
    # Some characters need to be replaced with underscore
    $re = [Regex]"[/*?""<>|]"
    $strDPResultsFileNameStart + $re.Replace($strObjectName,"_") + $strDPResultsFileNameEnd
}    


 # Main programm

 # Retrieve the configuration object and read the XSLT template.

$strXSLT = ReadObjectAttribute "CN=Change Tracking Log Configuration,CN=Server Configuration,CN=Configuration" "edsvaDeprovisioningReportXsltStylesheet"
 
 # Bind to the user object and read some of its attributes
$objUser = BindToObject $strUserAccountDN
$objUser.GetInfoEx(($strAttrToGetObjName, $strDPResultsAttrName), 0)
$strUserName = GetAttributeValue $objUser $strUserAccountDN $strAttrToGetObjName
$strDPResultsSource = GetAttributeValue $objUser $strUserAccountDN $strDPResultsAttrName
$objUser = $null

 # Start the transformation of an XML report to an HTML format
$objXSLT = New-Object -comobject "MSXML2.FreeThreadedDOMDocument"
$objXSLT.async = $false
$objXSLT.validateOnParse = $false
$objXSLT.resolveExternals = $false
$objXSLT.loadXML($strXSLT)
$objTemplate = New-Object -comobject "MSXML2.XSLTemplate"
$objTemplate.stylesheet = $objXSLT
$objXSLT = $null

$objProcessor = $objTemplate.createProcessor()

$objDPResultsSource = New-Object -comobject "MSXML2.FreeThreadedDOMDocument"
$objDPResultsSource.loadXML($strDPResultsSource)
	
$objProcessor.input = $objDPResultsSource
$objProcessor.transform()
$strResult = $objProcessor.output
$objXSLT = $null
$objProcessor = $null
$objDPResultsSource = $null
 # Save the file
$strDPResultsFileName = GetOutputFileName $strUserName
Out-File -FilePath $strDPResultsFileName -InputObject $strResult
 
If ($bSilentMode -eq $false)
{
    ReportMessage "The deprovisioning results report for the user object '$strUserAccountDN' has been saved into the file: '$strDPResultsFileName'.", "Info"
}    

