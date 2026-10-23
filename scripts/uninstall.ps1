<#
.SYNOPSIS
    Macify Windows 🍎 - Rollback & Uninstaller Script
.DESCRIPTION
    Stops the Macify process, removes the startup shortcut, and restores
    standard Windows default behavior.
#>

[CmdletBinding()]
param (
    [switch]$RemoveOptionalApps
)

Write-Host "==============================================" -ForegroundColor Yellow
Write-Host "     Macify Windows 🍎 - Restoring Defaults   " -ForegroundColor Yellow
Write-Host "==============================================" -ForegroundColor Yellow

# 1. Stop Running AHK Process
Write-Host "`n[1/3] Terminating Macify processes..." -ForegroundColor Cyan
Get-Process | Where-Object { $_.ProcessName -like "*AutoHotkey*" } | ForEach-Object {
    Write-Host "Stopping Process: $($_.ProcessName) (PID: $($_.Id))" -ForegroundColor Gray
    Stop-Process -Id $_.Id -Force -ErrorAction SilentlyContinue
}

# 2. Remove Startup Shortcut
Write-Host "`n[2/3] Removing Startup Entry..." -ForegroundColor Cyan
$StartupFolder = [System.IO.Path]::Combine($env:APPDATA, "Microsoft\Windows\Start Menu\Programs\Startup")
$StartupShortcut = Join-Path $StartupFolder "MacifyWindows.lnk"

if (Test-Path $StartupShortcut) {
    Remove-Item -Path $StartupShortcut -Force
    Write-Host "Removed startup shortcut: $StartupShortcut" -ForegroundColor Green
} else {
    Write-Host "No startup shortcut found." -ForegroundColor Gray
}

# 3. Optional Apps Removal
Write-Host "`n[3/3] Optional Desktop Apps..." -ForegroundColor Cyan
if ($RemoveOptionalApps) {
    Write-Host "Uninstalling Seelen UI..." -ForegroundColor Yellow
    winget uninstall --id Seelen.SeelenUI --silent --ErrorAction SilentlyContinue
    Write-Host "Uninstalling Flow Launcher..." -ForegroundColor Yellow
    winget uninstall --id Flow-Launcher.Flow-Launcher --silent --ErrorAction SilentlyContinue
} else {
    Write-Host "Optional packages (Seelen UI, Flow Launcher) were kept. Run with -RemoveOptionalApps if you want them uninstalled." -ForegroundColor Gray
}

Write-Host "`n==============================================" -ForegroundColor Green
Write-Host "  System Restored to Vanilla Windows State!   " -ForegroundColor Green
Write-Host "==============================================" -ForegroundColor Green
