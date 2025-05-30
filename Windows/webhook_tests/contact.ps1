$hookurl = ""
$content = "Contact successful"
$payload = [PSCustomObject]@{ content = $content } 
Invoke-RestMethod -Uri $hookUrl -Method Post -Body ($payload | ConvertTo-Json) -ContentType 'Application/Json'
