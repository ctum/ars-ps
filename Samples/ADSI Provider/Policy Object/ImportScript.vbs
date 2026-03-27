option explicit

 ' PARAMETERS OF SCRIPT YOU MAY MODIFY
 ' -----------------------------------
 '
 ' Before using the script, modify the following constants
 '
 ' Name of new script module
const strScriptModuleName= "CN=TestScriptModule"

 ' Path to the script file
const strScriptFilename= "MyScript.vbs"
 ' Set the language of the script
const strScriptLanguage = "VBScript"

 ' 
 ' -------------------------------------------------
 '

Dim FSO, ScriptFile
Set FSO = CreateObject("Scripting.FileSystemObject")
Set ScriptFile = FSO.OpenTextFile(strScriptFilename, 1)

const strContainerDN="EDMS://CN=Script Modules,CN=Configuration"
Dim ContainerObject
Set ContainerObject=GetObject(strContainerDN)

Dim newScriptModule
Set newScriptModule=ContainerObject.Create("edsScriptModule", strScriptModuleName)
newScriptModule.put "edsaScriptLanguage", strScriptLanguage
newScriptModule.put "edsaScriptText", ScriptFile.ReadAll
newScriptModule.put "edsaScriptType", 0

newScriptModule.SetInfo
