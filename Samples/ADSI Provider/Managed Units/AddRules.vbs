' DN of Managed Unit
const strMUName = "EDMS://CN=TestMU,CN=Managed Units,cn=Configuration"
Set muObject=GetObject(strMUName)
Set RuleCollection = muObject.MembershipRuleCollection

 ' Create a new Include by Query rule
Set rule1 = CreateObject("EDSIManagedUnitCondition")
rule1.Base = "EDMS://CN=Users,DC=mycompany,DC=com"
rule1.Filter = "(|(objectClass=user)(objectClass=computer))"
rule1.Type=1 
 ' Add the newly created membership rule to the rule collection
RuleCollection.Add rule1
muObject.SetInfo
wscript.echo "Rule added"

 ' Disable GUID lookup
RuleCollection.GuidLookupMustBePerformed = FALSE
 ' Reload the attribute values for Managed Unit after disabling the GUID lookup
muObject.GetInfo
 ' Create a new Include by Query rule
Set rule2 = CreateObject("EDSIManagedUnitCondition")
 ' Set the GUID for a container object where the search will start
rule2.BaseGuid = "26BD581B-7B7B-4605-A07B-EF42535E821D"
rule2.Filter = "(|(objectClass=user)(objectClass=group))"
rule2.Type=1
 ' Add the newly created membership rule to the rule collection
RuleCollection.Add rule2
muObject.SetInfo
wscript.echo "Rule added"
