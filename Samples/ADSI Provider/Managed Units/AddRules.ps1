#$cred = Get-Credential
#Connect-QADService -Service me64-ars65 -Proxy -Credential $cred
cls


# DN of Managed Unit
$strMU = "EDMS://CN=TestMU,cn=Department 1,CN=Managed Units,CN=Configuration"
 
$muObject = [ADSI] $strMU
$RuleCollection = $muObject.MembershipRuleCollection

# Create a new Include by Query rule
$rule1 = New-Object -ComObject "EDSIManagedUnitCondition"
$rule1.Base = "EDMS://CN=Users,DC=mycompany,DC=com"
$rule1.Filter = "(|(objectClass=user)(objectClass=computer))"
$rule1.Type = 1 
# Add the newly created membership rule to the rule collection
$RuleCollection.Add($rule1)
$muObject.SetInfo()
"Rule added"

# Disable GUID lookup
$RuleCollection.GuidLookupMustBePerformed = $false
# Reload the attribute values for Managed Unit after disabling the GUID lookup
$muObject.GetInfo()
# Create a new Include by Query rule
$rule2 = New-Object -ComObject "EDSIManagedUnitCondition"
# Set the GUID for a container object where the search will start
$rule2.BaseGuid = "26BD581B-7B7B-4605-A07B-EF42535E821D"
$rule2.Filter = "(|(objectClass=user)(objectClass=group))"
$rule2.Type = 1
# Add the newly created membership rule to the rule collection
$RuleCollection.Add($rule2)
$muObject.SetInfo()
"Rule added"

