$FilePath = C:\Windows\System32\calc.exe
$env:diagtrack_action_output = $FilePath
runexehelper.exe $FilePath 
