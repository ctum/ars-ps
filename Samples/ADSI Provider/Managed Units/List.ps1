# -----------------------------------
# PARAMETERS OF SCRIPT YOU MAY MODIFY
# -----------------------------------
# Before using the script, modify the following constants

# Set the DN of Managed Unit
  $strMU = "CN=TestMU,cn=Department 1,CN=Managed Units,CN=Configuration"
# Set the output file name
# $strOutputFile = "C:\temp\userlist.txt"
 
 
# -------------------------------------------------

$mu = Get-QADObject $strMU -proxy
$users = $mu.Item("edsaMember") | Get-QADUser
"Managed Unit: $strMU includes the following users:" | Out-File -FilePath $strOutputFile -Encoding "utf8"
$users | %{ $_.DN |Out-File -Encoding "utf8" -FilePath $strOutputFile -Append }
"The file $strOutputFile was created."

 