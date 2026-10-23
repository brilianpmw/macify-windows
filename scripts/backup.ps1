<#
.SYNOPSIS
    Macify Windows 🍎 - Automated System Configuration Backup
.DESCRIPTION
    Captures pre-existing desktop settings, startup folder entries, taskbar states,
    and user environment configurations before applying Macify customizations.
#>

[CmdletBinding()]
param (
    [string]$BackupName = (Get-Date -Format "yyyyMMdd-HHmmss")
)

$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ProjectRoot = Split-Path -Parent $ScriptDir
$BackupDir = Join-Path $ProjectRoot "backups\$BackupName"

Write-Host "==============================================" -ForegroundColor Cyan
Write-Host "     Macify Windows 🍎 - Automated Backup     " -ForegroundColor Cyan
Write-Host "==============================================" -ForegroundColor Cyan
Write-Host "Destination: $BackupDir" -ForegroundColor Yellow

if (-not (Test-Path $BackupDir)) {
    New-Item -ItemType Directory -Path $BackupDir -Force | Out-Null
}

# 1. Backup Startup Folder Entries
Write-Host "`n[1/4] Backing up Windows Startup Folder..." -ForegroundColor Cyan
$StartupFolder = [System.IO.Path]::Combine($env:APPDATA, "Microsoft\Windows\Start Menu\Programs\Startup")
$StartupBackup = Join-Path $BackupDir "Startup"
New-Item -ItemType Directory -Path $StartupBackup -Force | Out-Null
if (Test-Path $StartupFolder) {
    Copy-Item -Path "$StartupFolder\*" -Destination $StartupBackup -Recurse -Force -ErrorAction SilentlyContinue
    Write-Host "  -> Startup entries archived." -ForegroundColor Green
}

# 2. Backup Taskbar & Explorer Registry Configurations
Write-Host "`n[2/4] Backing up Explorer & Taskbar Registry..." -ForegroundColor Cyan
$RegistryBackup = Join-Path $BackupDir "Registry"
New-Item -ItemType Directory -Path $RegistryBackup -Force | Out-Null

$advancedReg = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
if (Test-Path $advancedReg) {
    reg export "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "$RegistryBackup\ExplorerAdvanced.reg" /y | Out-Null
    Write-Host "  -> Explorer Advanced registry exported." -ForegroundColor Green
}

# 3. Backup PowerShell Profile
Write-Host "`n[3/4] Backing up PowerShell Profile..." -ForegroundColor Cyan
if (Test-Path $PROFILE) {
    Copy-Item -Path $PROFILE -Destination (Join-Path $BackupDir "Microsoft.PowerShell_profile.ps1") -Force
    Write-Host "  -> PowerShell profile backed up." -ForegroundColor Green
} else {
    Write-Host "  -> No existing custom PowerShell profile found." -ForegroundColor Gray
}

# 4. Generate Metadata Manifest
Write-Host "`n[4/4] Writing Backup Manifest..." -ForegroundColor Cyan
$manifest = [PSCustomObject]@{
    BackupDate      = (Get-Date).ToString("o")
    BackupId        = $BackupName
    OSVersion       = (Get-CimInstance Win32_OperatingSystem).Version
    OSBuild         = (Get-CimInstance Win32_OperatingSystem).BuildNumber
    ComputerName    = $env:COMPUTERNAME
    UserName        = $env:USERNAME
    MacifyVersion   = "1.0.0"
}
$manifest | ConvertTo-Json -Depth 5 | Set-Content -Path "$BackupDir\manifest.json" -Encoding UTF8
Write-Host "  -> Manifest saved successfully." -ForegroundColor Green

Write-Host "`n==============================================" -ForegroundColor Green
Write-Host " Backup Completed Successfully! 💾            " -ForegroundColor Green
Write-Host " Identifier: $BackupName                      " -ForegroundColor Green
Write-Host "==============================================" -ForegroundColor Green
