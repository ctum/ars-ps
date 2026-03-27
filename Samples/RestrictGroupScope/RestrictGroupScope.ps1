#***********************************************************#
#  Script name : RestrictGroupScope.ps1                     #
#  Requires    : Active Role 6.7 or later                   #
#                                                           #
#  This policy script enforces the following policy:        #
#     Creation of Universal groups is not allowed.          #
#                                                           #
#***********************************************************#


function onCheckPropertyValues($Request)

{
# ---- Set some constants. Do not modify these values. ----
    $ADS_GROUP_TYPE_UNIVERSAL_GROUP     = 0x8
    $ADS_GROUP_TYPE_SECURITY_ENABLED    = 0x80000000
    
    
# ---- Check the in-process object class. The script returns the error message if you try to create a Universal group.                              
    if (($Request.Class -eq "group") -and `
                (($Request.get("groupType") -eq `
                ($ADS_GROUP_TYPE_UNIVERSAL_GROUP -bor $ADS_GROUP_TYPE_SECURITY_ENABLED))) -or `
                (($Request.get("groupType") -eq `
                $ADS_GROUP_TYPE_UNIVERSAL_GROUP)))
        {
          $Request.SetPolicyComplianceInfo("groupType", `
                      $Constants.EDS_POLICY_COMPLIANCE_ERROR, `
                      "Creation of Universal groups in this folder is not allowed.", `
                      $false)
        }
}

