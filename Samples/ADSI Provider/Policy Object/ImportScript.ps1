# PARAMETERS OF SCRIPT YOU MAY MODIFY
# -----------------------------------
#
# Before using the script, modify the following constants
#
# Name of new script module
	$ScriptModuleName = "TestScriptModule"
# Path to the script file
	$ScriptFilename = "C:\MyScript.vbs"
# Set the language of the script
	$ScriptLanguage = "VBScript"
# 
# -------------------------------------------------

# Several variants of reading text from a file

#$ScriptText = [string]::Join([Environment]::NewLine, (Get-Content $ScriptFilename))
#Get-Content $ScriptFilename -OutVariable $ScriptText|Out-Null
#$ScriptText = Get-Content $ScriptFilename –Delimiter “@#$”
$ScriptText = [System.IO.File]::ReadAllText($ScriptFilename)
New-QADObject -ParentContainer "CN=Script Modules,CN=Configuration" -Proxy -Name $ScriptModuleName -Type "edsScriptModule" -ObjectAttributes @{"edsaScriptLanguage"=$ScriptLanguage;"edsaScriptText"=$ScriptText;"edsaScriptType"=0}