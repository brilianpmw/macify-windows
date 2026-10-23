<#
.SYNOPSIS
    Starts all Macify Windows components cleanly in the interactive user session.
#>

$ahkExe = "$env:LOCALAPPDATA\Programs\AutoHotkey\v2\AutoHotkey64.exe"
$ahkScript = "c:\Users\brili\OneDrive\Documents\macify-windows\configs\autohotkey\Macify.ahk"

# 1. Stop old instances
Stop-Process -Name "AutoHotkey64" -Force -ErrorAction SilentlyContinue

# 2. Start Seelen UI Service if installed
$sluService = "$env:LOCALAPPDATA\Microsoft\WindowsApps\slu-service.exe"
if (Test-Path $sluService) {
    Get-Process | Where-Object { $_.ProcessName -like "*slu*" } | Stop-Process -Force -ErrorAction SilentlyContinue
    Start-Process -FilePath $sluService -WindowStyle Hidden
}

# 3. Start Seelen UI
Start-Process "explorer.exe" -ArgumentList "shell:AppsFolder\Seelen.SeelenUI_p6yyn03m1894e!App"

# 4. Start Flow Launcher
$flowExe = "$env:LOCALAPPDATA\FlowLauncher\Flow.Launcher.exe"
if (Test-Path $flowExe) {
    if (-not (Get-Process -Name "Flow.Launcher" -ErrorAction SilentlyContinue)) {
        Start-Process -FilePath $flowExe
    }
}

# 5. Launch Macify Keyboard Engine via Explorer shell (attaches to interactive desktop)
$StartupShortcut = [System.IO.Path]::Combine($env:APPDATA, "Microsoft\Windows\Start Menu\Programs\Startup\MacifyWindows.lnk")
if (Test-Path $StartupShortcut) {
    Start-Process "explorer.exe" -ArgumentList "`"$StartupShortcut`""
} else {
    Start-Process "explorer.exe" -ArgumentList "`"$ahkScript`""
}

Write-Host "All Macify Windows services started!" -ForegroundColor Green
