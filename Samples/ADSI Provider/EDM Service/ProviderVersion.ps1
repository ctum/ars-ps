$namespace = [ADSI]"EDMS:"
[xml]$xml = $namespace.VersionInfo
$xml.VersionInfo.FileVersion

$v0 = $xml.VersionInfo.FileVersionInfo.MajorHiVersion
$v1 = $xml.VersionInfo.FileVersionInfo.MajorLoVersion
$v2 = $xml.VersionInfo.FileVersionInfo.MinorHiVersion
$v3 = $xml.VersionInfo.FileVersionInfo.MinorLoVersion
Write-Host EDM ADSI provider $v0'.'$v1'.'$v2'.'$v3 detected.



