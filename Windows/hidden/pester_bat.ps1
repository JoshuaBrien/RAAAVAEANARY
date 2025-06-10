$pesterVersion = (Get-Module -Name Pester -ListAvailable | Where-Object { $_.Version }).Version.ToString()
Write-Output $pesterVersion
Set-Location "C:\Program Files (x86)\WindowsPowerShell\Modules\Pester\$pesterVersion\bin"
#filepath 
Pester.bat; C:\Windows\system32\calc.exe.