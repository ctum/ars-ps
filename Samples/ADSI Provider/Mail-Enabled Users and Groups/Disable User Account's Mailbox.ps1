Set-QADUser "CN=John Smith,OU=Sales,DC=mydomain,DC=com" -Proxy -ObjectAttributes @{"edsaDeleteEmail"=$true}
"Done!"