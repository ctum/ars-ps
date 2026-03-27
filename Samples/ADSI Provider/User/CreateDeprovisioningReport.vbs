Option Explicit
 ' -------------------------------------------------
 ' PARAMETERS OF SCRIPT YOU MAY MODIFY
 ' -------------------------------------------------
 '
 ' Before using the script, modify the following constants
 '
 ' Set the distinguished name of a deprovisioned user for which you want to create the deprovisioning results report
Const strUserAccountDN          = "CN=Samuel Smith - Deprovisioned 9\/28\/2007,OU=Sales,DC=mycompany,DC=com"
 
 ' -------------------------------------------------
 ' 
 ' -------------------------------------------------
 '
 ' The script title
 Const strScriptTitle            = "Creating Deprovisioning Results Report"
 
  ' File name for the deprovisioning results report
  ' The first part of the file name
 Const strDPResultsFileNameStart = "Deprovisioning Results - "
  ' The file name extension
 Const strDPResultsFileNameEnd   = ".htm"

 ' The user object attribute where the XML format report is saved
Const strDPResultsAttrName      = "edsvaDeprovisionReportXML"
 
 ' The user object attribute used to generate the report file name
Const strAttrToGetObjName       = "name"

 ' The Active Roles provider name
Const strBindPrefix             = "EDMS://"
 
 ' Silent mode
Const bSilentMode               = False

 ' Output a message
Sub ReportMessage(ByVal strInfo, ByVal strMode)
  If strMode = "Error" Then 
      MsgBox "(" + strScriptTitle + ") " + strInfo,vbOk+vbCritical 
                       Else
      MsgBox "(" + strScriptTitle + ") " + strInfo,vbOk+vbInformation 
  End If                     
    'WScript.Echo "[" + strScriptTitle + "] " + strInfo
End Sub

 ' Bind to the specified directory object
Function BindToObject(ByVal strDN)
    On Error Resume Next
    Dim object
    Set object = GetObject(strBindPrefix + strDN)
    If err.number <> 0 Then
        ReportMessage "Cannot bind to '" + strDN + "'" + vbcrlf + "Error code: " + Cstr(Err.number),"Error" 
        WScript.Quit(err.number)
    End If

    Set BindToObject = object
End Function

 ' Get the specified attribute value
Function GetAttributeValue(ByVal obj, ByVal strDN, ByVal strAttrName)
    On Error Resume Next
    Dim value
    value = obj.Get(strAttrName)
    If err.number <> 0 Then
        ReportMessage "Failed to retrieve the attribute '" + strAttrName + "' from object '" + strDN + "'", "Error"
        WScript.Quit(err.number)
    End If

    GetAttributeValue = value
End Function

 ' Get the specified attribute value
Function ReadObjectAttribute(ByVal strDN, ByVal strAttrName)
    On Error Resume Next
    Dim object, value
    Set object = BindToObject(strDN)
    object.GetInfoEx Array(strAttrName), 0
    value = GetAttributeValue(object, strDN, strAttrName)
    Set object = Nothing

    ReadObjectAttribute = value
End Function

 ' Initializing the DOM Document object and loading XML from string
Function LoadXML(ByVal strXML)
    On Error Resume Next
    Dim objXMLDoc
    Set objXMLdoc = CreateObject("MSXML2.FreeThreadedDOMDocument.4.0")
    objXMLDoc.async = False
    objXMLDoc.validateOnParse = False
    objXMLDoc.resolveExternals = False
    objXMLdoc.loadXML(strXML)
    If err.number <> 0 Then
        ReportMessage "Cannot load the XML source to DOM.", "Error"
        WScript.Quit(err.number)
    End If
    
    Set LoadXML = objXMLDoc
End Function

 ' Create the transforamtion template
Function CreateTemplate(ByVal strXSLT)
    On Error Resume Next
    Dim objTemplate, objXSLT
    Set objXSLT = LoadXML(strXSLT)
    Set objTemplate = CreateObject("MSXML2.XSLTemplate.4.0")
    objTemplate.stylesheet = objXSLT
    Set objXSLT = Nothing

    Set CreateTemplate = objTemplate
End Function

 ' Generate the output file name
Function GetOutputFileName(ByVal strObjectName)
    ' Some characters need to be replaced with underscore
    strObjectName = Replace(strObjectName, "/", "_")
    strObjectName = Replace(strObjectName, "*", "_")
    strObjectName = Replace(strObjectName, "?", "_")
    strObjectName = Replace(strObjectName, """", "_")
    strObjectName = Replace(strObjectName, "<", "_")
    strObjectName = Replace(strObjectName, ">", "_")
    strObjectName = Replace(strObjectName, "|", "_")
    GetOutputFileName = strDPResultsFileNameStart + strObjectName + strDPResultsFileNameEnd
End Function

 ' Save the report file
Sub SaveDPResultToFile(ByVal strDPResultsFileName, ByVal strDPResult)
    On Error Resume Next
    Dim fso, fileHTML
    Set fso = CreateObject("Scripting.FileSystemObject")
    Set fileHTML = fso.OpenTextFile(strDPResultsFileName, 2, True, -1) '2, True)
    If err.number <> 0 Then
        ReportMessage "Failed to write into the file: '" + strDPResultsFileName + "'.", "Error"
        WScript.Quit(err.number)
    End If

    fileHTML.WriteLine(strDPResult)
    If err.number <> 0 Then
        ReportMessage "Failed to write into the file: '" + strDPResultsFileName + "'.", "Error"
        WScript.Quit(err.number)
    End If

    fileHTML.Close
    Set fileHTML = Nothing
    Set fso = Nothing
End Sub

 ' Main programm
On Error Goto 0


 ' Retrieve the configuration object and read the XSLT template.
Dim strXSLT
strXSLT = ReadObjectAttribute("CN=Change Tracking Log Configuration,CN=Server Configuration,CN=Configuration", "edsvaDeprovisioningReportXsltStylesheet")
 
 ' Bind to the user object and read some of its attributes
Dim objUser, strUserName, strDPResultsSource
Set objUser = BindToObject(strUserAccountDN)
objUser.GetInfoEx Array(strAttrToGetObjName, strDPResultsAttrName), 0
strUserName = GetAttributeValue(objUser, strUserAccountDN, strAttrToGetObjName)
strDPResultsSource = GetAttributeValue(objUser, strUserAccountDN, strDPResultsAttrName)
Set objUser = Nothing

 ' Start the transformation of an XML report to an HTML format
Dim objXSLT, objDPResultsSource, objProcessor, strResult
Set objXSLT = CreateTemplate(strXSLT)
Set objProcessor = objXSLT.createProcessor()
objProcessor.addParameter "SaveMode", 1
objProcessor.addParameter "Header", "Deprovisioning Results for" + strUserName
Set objDPResultsSource = LoadXML(strDPResultsSource)
objProcessor.input = objDPResultsSource
objProcessor.transform()
strResult = objProcessor.output
Set objXSLT = Nothing
Set objProcessor = Nothing
Set objDPResultsSource = Nothing

 ' Save the file
Dim strDPResultsFileName
strDPResultsFileName = GetOutputFileName(strUserName)
Call SaveDPResultToFile(strDPResultsFileName, strResult)

 
If Not bSilentMode Then
    ReportMessage "The deprovisioning results report for the user object '" + strUserAccountDN + "' has been saved into the file: '" + strDPResultsFileName + "'.", "Info"
End If
