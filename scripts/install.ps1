<#
.SYNOPSIS
    Macify Windows 🍎 - Automated Installation Script
.DESCRIPTION
    Installs AutoHotkey v2 (via WinGet), sets up the Macify keyboard engine,
    configures automatic startup, and offers to install optional macOS desktop UI components (Seelen UI, Flow Launcher).
#>

[CmdletBinding()]
param (
    [switch]$WithSeelenUI,
    [switch]$WithFlowLauncher
)

$ErrorActionPreference = "Stop"

Write-Host "==============================================" -ForegroundColor Cyan
Write-Host "       Project: Macify Windows 🍎 Setup       " -ForegroundColor Cyan
Write-Host "==============================================" -ForegroundColor Cyan

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ProjectRoot = Split-Path -Parent $ScriptDir
$AhkScriptPath = Join-Path $ProjectRoot "configs\autohotkey\Macify.ahk"
$StartupFolder = [System.IO.Path]::Combine($env:APPDATA, "Microsoft\Windows\Start Menu\Programs\Startup")
$StartupShortcut = Join-Path $StartupFolder "MacifyWindows.lnk"

# 1. Check or Install AutoHotkey v2
Write-Host "`n[1/4] Checking AutoHotkey v2..." -ForegroundColor Yellow
$ahkInstalled = (Get-Command AutoHotkey64.exe -ErrorAction SilentlyContinue) -or (Test-Path "$env:ProgramFiles\AutoHotkey\v2\AutoHotkey64.exe") -or (Test-Path "$env:LOCALAPPDATA\Programs\AutoHotkey\v2\AutoHotkey64.exe")

if (-not $ahkInstalled) {
    Write-Host "AutoHotkey v2 not detected. Installing via WinGet..." -ForegroundColor Cyan
    winget install --id AutoHotkey.AutoHotkey --source winget --accept-package-agreements --accept-source-agreements --silent
    Write-Host "AutoHotkey v2 successfully installed!" -ForegroundColor Green
} else {
    Write-Host "AutoHotkey v2 is already installed." -ForegroundColor Green
}

# Locate AHK v2 executable
$ahkExe = "$env:ProgramFiles\AutoHotkey\v2\AutoHotkey64.exe"
if (-not (Test-Path $ahkExe)) {
    $ahkExe = "$env:LOCALAPPDATA\Programs\AutoHotkey\v2\AutoHotkey64.exe"
}
if (-not (Test-Path $ahkExe)) {
    $cmd = Get-Command AutoHotkey64.exe -ErrorAction SilentlyContinue
    if ($cmd) { $ahkExe = $cmd.Source }
}

# 2. Configure Startup Shortcut
Write-Host "`n[2/4] Configuring Auto-Startup..." -ForegroundColor Yellow
$WshShell = New-Object -ComObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut($StartupShortcut)
$Shortcut.TargetPath = $ahkExe
$Shortcut.Arguments = "`"$AhkScriptPath`""
$Shortcut.WorkingDirectory = Split-Path -Parent $AhkScriptPath
$Shortcut.Description = "Macify Windows Keyboard Engine"
$Shortcut.Save()
Write-Host "Startup shortcut created at: $StartupShortcut" -ForegroundColor Green

# 3. Launch Macify Keyboard Engine
Write-Host "`n[3/4] Launching Macify Keyboard Engine..." -ForegroundColor Yellow
Stop-Process -Name "AutoHotkey64" -ErrorAction SilentlyContinue
Start-Process -FilePath $ahkExe -ArgumentList "`"$AhkScriptPath`""
Write-Host "Macify engine is now active!" -ForegroundColor Green

# 4. Optional Components
Write-Host "`n[4/4] Optional macOS Desktop Enhancements..." -ForegroundColor Yellow
if ($WithSeelenUI) {
    Write-Host "Installing Seelen UI (macOS Dock & Top Bar)..." -ForegroundColor Cyan
    winget install --id Seelen.SeelenUI --source winget --accept-package-agreements --accept-source-agreements
} else {
    Write-Host "Tip: Run with -WithSeelenUI to automatically install macOS Dock & Top Bar." -ForegroundColor Gray
}

if ($WithFlowLauncher) {
    Write-Host "Installing Flow Launcher (macOS Spotlight Search)..." -ForegroundColor Cyan
    winget install --id Flow-Launcher.Flow-Launcher --source winget --accept-package-agreements --accept-source-agreements
} else {
    Write-Host "Tip: Run with -WithFlowLauncher to automatically install Spotlight Search." -ForegroundColor Gray
}

Write-Host "`n==============================================" -ForegroundColor Green
Write-Host "  Macify Windows is Ready! 🍎                " -ForegroundColor Green
Write-Host "  Press Ctrl + Shift + G to toggle Gaming Mode" -ForegroundColor Green
Write-Host "==============================================" -ForegroundColor Green
