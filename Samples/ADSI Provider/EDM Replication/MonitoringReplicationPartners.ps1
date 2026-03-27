
$strResult = ""
Get-QADObject -SearchRoot "CN=Configuration Databases,CN=Server Configuration,cn=Configuration" -Type 'edsReplicationPartner' | %{
    $de = $_.DirectoryEntry
    $de.RefreshCache(("edsvaARServices","edsaReplicationRole","edsaReplicationStatus", "edsaErrorMessage"))
    $strResult += "Computer: " + $de.InvokeGet("edsvaARServices") + "`n"
    
    $strResult += "Replication role: "
    $strResult += %{
    switch ($de.InvokeGet("edsaReplicationRole")) {
        1 { "[Publisher]" }
        2 { "[Subscriber]" }
        3 { "[Standalone]" }
        default { "[unknown replication role]" }
    }}
    $strResult += "; Replication Status: " 
    $strResult += %{
    switch ($de.InvokeGet("edsaReplicationStatus")) {
        1 { "[Start]" }
        2 { "[Succeed]" }
        3 { "[In progress]" }
        4 { "[Idle]" }
        5 { "[Retry]" }
        6 { "[Fail]" }
        default { "[unknown status]" }
    }}
    $strResult += "`n"
    if ($de.InvokeGet("edsaErrorMessage") -ne $null)
    {
        $strResult += "Last action message: " + $de.InvokeGet("edsaErrorMessage")
    }
    $strResult += "`n===================================`n"

}

$strResult

