#Requires AutoHotkey v2.0
#SingleInstance Force
#UseHook true
InstallKeybdHook()
Persistent

; ==============================================================================
;  PROJECT: Macify Windows 🍎
;  File: Macify.ahk (AutoHotkey v2 Core Keyboard Engine - Enhanced)
;  Description: Rock-solid macOS shortcut replication for Windows 11.
;               Supports Apple Magic Keyboard (Bluetooth/USB) & standard PC keyboards.
; ==============================================================================

; --- Tray Configuration ---
A_IconTip := "Macify Windows (Active)"
TraySetIcon("shell32.dll", 44) ; Star icon

; --- Global State ---
global isSuspended := false

; --- Tray Menu ---
A_TrayMenu.Delete()
A_TrayMenu.Add("Macify Windows v1.1", (*) => Run("https://github.com/brilianpmw/macify-windows"))
A_TrayMenu.Disable("Macify Windows v1.1")
A_TrayMenu.Add() ; Separator
A_TrayMenu.Add("Toggle Gaming Mode (Ctrl+Shift+G)", ToggleSuspend)
A_TrayMenu.Add("Reload Script", (*) => Reload())
A_TrayMenu.Add("Exit", (*) => ExitApp())

; ------------------------------------------------------------------------------
;  HELPER: Clean Send Function
;  Releases physical Command (LWin/LAlt) before dispatching Windows Ctrl shortcuts.
;  This prevents Windows 11 from seeing "Win + Ctrl + key" or opening Copilot/Start.
; ------------------------------------------------------------------------------
SendCmd(shortcut) {
    SetKeyDelay(-1)
    ; Release Windows & Alt modifiers to prevent key collision
    SendEvent("{Blind}{LWin up}{RWin up}{LAlt up}{RAlt up}" . shortcut)
}

; ------------------------------------------------------------------------------
;  HOTKEY: Toggle Gaming Mode (Suspend/Resume all shortcuts)
; ------------------------------------------------------------------------------
^+g::ToggleSuspend()

ToggleSuspend(*) {
    global isSuspended
    isSuspended := !isSuspended
    Suspend(isSuspended)
    if (isSuspended) {
        A_IconTip := "Macify Windows (PAUSED - Gaming Mode)"
        ToolTip("Macify: Gaming Mode Enabled (Shortcuts Paused)")
    } else {
        A_IconTip := "Macify Windows (Active)"
        ToolTip("Macify: macOS Shortcuts Active")
    }
    SetTimer(() => ToolTip(), -2000)
}

; ==============================================================================
;  SECTION 1: APPLICATION-SPECIFIC LOGIC (Terminal, Code, Browsers)
; ==============================================================================

; --- Terminal Applications (Windows Terminal, cmd, powershell, Git Bash) ---
GroupAdd("Terminals", "ahk_exe WindowsTerminal.exe")
GroupAdd("Terminals", "ahk_exe wt.exe")
GroupAdd("Terminals", "ahk_exe cmd.exe")
GroupAdd("Terminals", "ahk_exe powershell.exe")
GroupAdd("Terminals", "ahk_exe bash.exe")

#HotIf WinActive("ahk_group Terminals")
; In terminal: Cmd+C copies, Cmd+V pastes, while Ctrl+C remains SIGINT!
$#c::SendCmd("^+c")           ; Mac Cmd+C -> Terminal Copy (Ctrl+Shift+C)
$!c::SendCmd("^+c")           ; Alt+C fallback -> Terminal Copy
$#v::SendCmd("^+v")           ; Mac Cmd+V -> Terminal Paste (Ctrl+Shift+V)
$!v::SendCmd("^+v")           ; Alt+V fallback -> Terminal Paste
#HotIf

; --- Visual Studio Code ---
#HotIf WinActive("ahk_exe Code.exe")
$#p::SendCmd("^p")            ; Cmd+P -> Quick Open
$!p::SendCmd("^p")
$#+p::SendCmd("^+p")          ; Cmd+Shift+P -> Command Palette
$!+p::SendCmd("^+p")
$#/::SendCmd("^/")            ; Cmd+/ -> Toggle Comment
$!/::SendCmd("^/")
$#[::SendCmd("^[")            ; Cmd+[ -> Outdent
$!]::SendCmd("^]")
#HotIf

; --- Web Browsers ---
GroupAdd("Browsers", "ahk_exe msedge.exe")
GroupAdd("Browsers", "ahk_exe chrome.exe")
GroupAdd("Browsers", "ahk_exe firefox.exe")
GroupAdd("Browsers", "ahk_exe brave.exe")

#HotIf WinActive("ahk_group Browsers")
$#l::SendCmd("^l")            ; Cmd+L -> Focus Address Bar
$!l::SendCmd("^l")
$#r::SendCmd("^r")            ; Cmd+R -> Reload Page
$!r::SendCmd("^r")
$#+r::SendCmd("^+r")          ; Cmd+Shift+R -> Hard Reload
$!+r::SendCmd("^+r")
$#[::SendCmd("!{Left}")       ; Cmd+[ -> History Back
$#]::SendCmd("!{Right}")      ; Cmd+] -> History Forward
#HotIf

; ==============================================================================
;  SECTION 2: GLOBAL CORE SHORTCUTS (Dual mapped for Apple & PC Keyboards)
;  Apple Keyboards send LWin (#) for Command.
;  Standard PC Keyboards have thumb on Alt (!).
; ==============================================================================

; --- Clipboard: Copy ---
$#c::SendCmd("^c")
$!c::SendCmd("^c")

; --- Clipboard: Paste ---
$#v::SendCmd("^v")
$!v::SendCmd("^v")

; --- Clipboard: Cut ---
$#x::SendCmd("^x")
$!x::SendCmd("^x")

; --- Select All ---
$#a::SendCmd("^a")
$!a::SendCmd("^a")

; --- Undo & Redo ---
$#z::SendCmd("^z")
$!z::SendCmd("^z")
$#+z::SendCmd("^y")
$!+z::SendCmd("^y")

; --- Save & Find ---
$#s::SendCmd("^s")
$!s::SendCmd("^s")
$#f::SendCmd("^f")
$!f::SendCmd("^f")

; --- Tabs & Windows ---
$#t::SendCmd("^t")
$!t::SendCmd("^t")
$#w::SendCmd("^w")
$!w::SendCmd("^w")
$#q::SendCmd("!{F4}")
$!q::SendCmd("!{F4}")
$#m::SendCmd("#{Down}")
$!m::SendCmd("#{Down}")

; --- Application Switching (Cmd + Tab) ---
$#Tab::SendCmd("!{Tab}")

; --- Spotlight / Launcher (Cmd + Space) ---
$#Space::SendCmd("!{Space}")
$!Space::SendCmd("!{Space}")

; ==============================================================================
;  SECTION 3: SCREENSHOT CAPTURE (macOS Style)
;  Cmd + Shift + 4 -> Interactive Snipping Tool (Region Capture)
;  Cmd + Shift + 3 -> Fullscreen Screenshot (to Clipboard)
;  Cmd + Shift + 5 -> Snipping Tool / Screen Recording Toolbar
; ==============================================================================
$#+4::SendCmd("#+s")
$!+4::SendCmd("#+s")

$#+3::SendCmd("{PrintScreen}")
$!+3::SendCmd("{PrintScreen}")

$#+5::SendCmd("#+s")
$!+5::SendCmd("#+s")

; ==============================================================================
;  SECTION 4: TEXT NAVIGATION & EDITING (Option / Command Jumps)
;  Option = LAlt (!), Command = LWin (#)
; ==============================================================================

; --- Word Navigation (Option + Left/Right) ---
$!Left::SendCmd("^{Left}")
$!Right::SendCmd("^{Right}")

; --- Word Deletion (Option + Backspace / Delete) ---
$!Backspace::SendCmd("^{Backspace}")
$!Delete::SendCmd("^{Delete}")

; --- Line Navigation (Command + Left/Right) ---
$#Left::SendCmd("{Home}")
$#Right::SendCmd("{End}")

; --- Document Top / Bottom (Command + Up/Down) ---
$#Up::SendCmd("^{Home}")
$#Down::SendCmd("^{End}")

; --- Word Selection (Option + Shift + Left/Right) ---
$!+Left::SendCmd("^+{Left}")
$!+Right::SendCmd("^+{Right}")

; --- Line Selection (Command + Shift + Left/Right) ---
$#+Left::SendCmd("+{Home}")
$#+Right::SendCmd("+{End}")

; --- Document Selection (Command + Shift + Up/Down) ---
$#+Up::SendCmd("^+{Home}")
$#+Down::SendCmd("^+{End}")
