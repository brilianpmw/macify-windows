<#
.SYNOPSIS
    Toggles Macify Windows Gaming Mode via command line or shortcut.
#>

$ahkExe = "$env:ProgramFiles\AutoHotkey\v2\AutoHotkey64.exe"
if (-not (Test-Path $ahkExe)) {
    $ahkExe = "$env:LOCALAPPDATA\Programs\AutoHotkey\v2\AutoHotkey64.exe"
}

# Sends Ctrl+Shift+G keystroke to toggle gaming mode in the active hook
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.SendKeys]::SendWait("^+G")
Write-Host "Toggled Macify Gaming Mode (Shortcuts Suspended/Resumed)." -ForegroundColor Cyan
