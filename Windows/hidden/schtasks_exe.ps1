$time = (Get-Date).AddMinutes(1) | Get-Date -Format "HH:mm"
$date = Get-Date -Format "dd/MM/yyyy"
Write-output $date
Write-output $time
schtasks /CREATE /TN "RavenOneTimeTask" /TR "C:\Windows\System32\notepad.exe" /SC ONCE /SD $date /ST $time /F
