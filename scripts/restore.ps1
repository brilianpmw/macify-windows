<#
.SYNOPSIS
    Macify Windows 🍎 - Rollback & State Restoration Script
.DESCRIPTION
    Reverts all Macify Windows customizations, restores pre-existing registry configurations,
    restores original startup items from a selected backup, and stops all Macify processes.
#>

[CmdletBinding()]
param (
    [string]$BackupId,
    [switch]$UninstallApps
)

$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ProjectRoot = Split-Path -Parent $ScriptDir
$BackupsRoot = Join-Path $ProjectRoot "backups"

Write-Host "==============================================" -ForegroundColor Yellow
Write-Host "     Macify Windows 🍎 - System Rollback      " -ForegroundColor Yellow
Write-Host "==============================================" -ForegroundColor Yellow

# 1. Stop all Macify-related processes
Write-Host "`n[1/5] Stopping Macify processes..." -ForegroundColor Cyan
Get-Process | Where-Object { $_.ProcessName -match "AutoHotkey|seelen-ui|Flow\.Launcher" } | ForEach-Object {
    Write-Host "  -> Terminating: $($_.ProcessName) (PID: $($_.Id))" -ForegroundColor Gray
    Stop-Process -Id $_.Id -Force -ErrorAction SilentlyContinue
}

# 2. Locate Selected or Latest Backup
Write-Host "`n[2/5] Locating Backup Archive..." -ForegroundColor Cyan
if (-not (Test-Path $BackupsRoot)) {
    Write-Host "No backup folder found. Performing standard cleanup." -ForegroundColor Yellow
    $SelectedBackup = $null
} else {
    if ($BackupId) {
        $SelectedBackup = Join-Path $BackupsRoot $BackupId
    } else {
        $latest = Get-ChildItem -Path $BackupsRoot -Directory | Sort-Object CreationTime -Descending | Select-Object -First 1
        if ($latest) {
            $SelectedBackup = $latest.FullName
        }
    }
}

if ($SelectedBackup -and (Test-Path $SelectedBackup)) {
    Write-Host "Restoring from: $SelectedBackup" -ForegroundColor Green

    # 3. Restore Registry Settings
    Write-Host "`n[3/5] Restoring Explorer Registry..." -ForegroundColor Cyan
    $regFile = Join-Path $SelectedBackup "Registry\ExplorerAdvanced.reg"
    if (Test-Path $regFile) {
        reg import "$regFile" | Out-Null
        Write-Host "  -> Original Explorer registry keys restored." -ForegroundColor Green
    }

    # 4. Restore Startup Folder
    Write-Host "`n[4/5] Restoring Startup entries..." -ForegroundColor Cyan
    $StartupFolder = [System.IO.Path]::Combine($env:APPDATA, "Microsoft\Windows\Start Menu\Programs\Startup")
    $MacifyShortcut = Join-Path $StartupFolder "MacifyWindows.lnk"
    if (Test-Path $MacifyShortcut) {
        Remove-Item -Path $MacifyShortcut -Force -ErrorAction SilentlyContinue
        Write-Host "  -> Removed Macify startup hook." -ForegroundColor Green
    }
    
    $savedStartup = Join-Path $SelectedBackup "Startup"
    if (Test-Path $savedStartup) {
        Copy-Item -Path "$savedStartup\*" -Destination $StartupFolder -Recurse -Force -ErrorAction SilentlyContinue
        Write-Host "  -> Restored pre-existing startup items." -ForegroundColor Green
    }
} else {
    Write-Host "`n[3/5 & 4/5] No previous backup archive to restore. Removing Macify shortcut..." -ForegroundColor Yellow
    $StartupFolder = [System.IO.Path]::Combine($env:APPDATA, "Microsoft\Windows\Start Menu\Programs\Startup")
    $MacifyShortcut = Join-Path $StartupFolder "MacifyWindows.lnk"
    if (Test-Path $MacifyShortcut) {
        Remove-Item -Path $MacifyShortcut -Force -ErrorAction SilentlyContinue
    }
}

# 5. Optional Uninstallation of Third-Party Packages
Write-Host "`n[5/5] Optional Package Removal..." -ForegroundColor Cyan
if ($UninstallApps) {
    Write-Host "Uninstalling Seelen UI and Flow Launcher..." -ForegroundColor Yellow
    winget uninstall --id Seelen.SeelenUI --silent --ErrorAction SilentlyContinue
    winget uninstall --id Flow-Launcher.Flow-Launcher --silent --ErrorAction SilentlyContinue
    Write-Host "  -> Packages uninstalled." -ForegroundColor Green
} else {
    Write-Host "  -> Seelen UI & Flow Launcher kept (pass -UninstallApps to remove them)." -ForegroundColor Gray
}

Write-Host "`n==============================================" -ForegroundColor Green
Write-Host "  System Restored to Original State! 🚀       " -ForegroundColor Green
Write-Host "==============================================" -ForegroundColor Green
