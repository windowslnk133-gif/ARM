# 確保下載時使用正確的安全協議
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# 1. 定義下載網址與本地路徑
$url = "https://github.com"
$savePath = "$env:TEMP\ARM_Setup.7z"
$desktopDir = "$env:USERPROFILE\Desktop\ARM_App"

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "  installing (91MB)" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan

# 2. 開始下載檔案（這裡已修正為正確的 -OutFile）
try {
    Invoke-WebRequest -Uri $url -OutFile $savePath -UserAgent "Mozilla/5.0"
} catch {
    Write-Error "install error"
    exit
}

# 3. 自動建立桌面資料夾並解壓 .7z 檔案
if (!(Test-Path $desktopDir)) { 
    New-Item -ItemType Directory -Path $desktopDir | Out-Null 
}

Write-Host "install on [ARM_App] ..." -ForegroundColor Yellow
tar -xf $savePath -C $desktopDir

# 4. 刪除暫存的壓縮檔
if (Test-Path $savePath) {
    Remove-Item $savePath
}

Write-Host ""
Write-Host "[Notification] Success" -ForegroundColor Green
Write-Host "==========================================" -ForegroundColor Green

