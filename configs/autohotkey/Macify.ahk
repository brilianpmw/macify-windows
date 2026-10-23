#Requires AutoHotkey v2.0
#SingleInstance Force
Persistent

; ==============================================================================
;  PROJECT: Macify Windows 🍎
;  File: Macify.ahk (AutoHotkey v2 Core Keyboard Engine)
;  Description: Replicates macOS muscle memory on Windows 11 with support for
;               Apple Magic Keyboard and standard PC keyboards.
; ==============================================================================

; --- Tray Configuration ---
A_IconTip := "Macify Windows (Active)"
TraySetIcon("shell32.dll", 44) ; Star/favorite icon

; --- Global State ---
global isSuspended := false

; --- Tray Menu ---
A_TrayMenu.Delete()
A_TrayMenu.Add("Macify Windows v1.0", (*) => Run("https://github.com/"))
A_TrayMenu.Disable("Macify Windows v1.0")
A_TrayMenu.Add() ; Separator
A_TrayMenu.Add("Toggle Gaming Mode (Ctrl+Shift+G)", ToggleSuspend)
A_TrayMenu.Add("Reload Script", (*) => Reload())
A_TrayMenu.Add("Exit", (*) => ExitApp())

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
#c::Send("^+c")           ; Mac Cmd+C -> Terminal Copy (Ctrl+Shift+C)
#v::Send("^+v")           ; Mac Cmd+V -> Terminal Paste (Ctrl+Shift+V)
!c::Send("^+c")           ; Alt+C fallback
!v::Send("^+v")           ; Alt+V fallback
#HotIf

; --- Visual Studio Code ---
#HotIf WinActive("ahk_exe Code.exe")
#p::Send("^p")            ; Cmd+P -> Quick Open
#+p::Send("^+p")          ; Cmd+Shift+P -> Command Palette
#/::Send("^/")            ; Cmd+/ -> Toggle Comment
#[::Send("^[")            ; Cmd+[ -> Outdent
#]::Send("^]")            ; Cmd+] -> Indent
#HotIf

; --- Web Browsers ---
GroupAdd("Browsers", "ahk_exe msedge.exe")
GroupAdd("Browsers", "ahk_exe chrome.exe")
GroupAdd("Browsers", "ahk_exe firefox.exe")
GroupAdd("Browsers", "ahk_exe brave.exe")

#HotIf WinActive("ahk_group Browsers")
#l::Send("^l")            ; Cmd+L -> Focus Address Bar
#r::Send("^r")            ; Cmd+R -> Reload Page
#+r::Send("^+r")          ; Cmd+Shift+R -> Hard Reload
#[::Send("!{Left}")       ; Cmd+[ -> History Back
#]::Send("!{Right}")      ; Cmd+] -> History Forward
#HotIf

; ==============================================================================
;  SECTION 2: GLOBAL CORE SHORTCUTS (Command Key Mappings)
;  Note: On Apple keyboards, Command sends LWin (#). On standard PC keyboards,
;        we also provide Alt mappings so thumb-modifier works naturally.
; ==============================================================================

; --- Standard Clipboard & Document Operations ---
#c::Send("^c")            ; Cmd+C -> Copy
#v::Send("^v")            ; Cmd+V -> Paste
#x::Send("^x")            ; Cmd+X -> Cut
#a::Send("^a")            ; Cmd+A -> Select All
#z::Send("^z")            ; Cmd+Z -> Undo
#+z::Send("^y")           ; Cmd+Shift+Z -> Redo
#s::Send("^s")            ; Cmd+S -> Save
#f::Send("^f")            ; Cmd+F -> Find
#t::Send("^t")            ; Cmd+T -> New Tab

; --- Window & Application Lifecycle ---
#w::Send("^w")            ; Cmd+W -> Close Tab / Window
#q::Send("!{F4}")         ; Cmd+Q -> Quit Application
#m::Send("#{Down}")       ; Cmd+M -> Minimize Window

; --- Application Switching (Cmd + Tab) ---
; Replicates Mac Cmd+Tab using Windows Task Switcher
#Tab::Send("!{Tab}")

; --- Spotlight / Launcher (Cmd + Space) ---
#Space::Send("!{Space}")

; ==============================================================================
;  SECTION 3: SCREENSHOT CAPTURE (macOS Style)
; ==============================================================================
; Cmd + Shift + 4 -> Region Screenshot (Windows Snipping Tool)
#+4::Send("#+s")

; Cmd + Shift + 3 -> Fullscreen Screenshot (PrintScreen)
#+3::Send("{PrintScreen}")

; ==============================================================================
;  SECTION 4: TEXT NAVIGATION & EDITING (Option / Command Jumps)
;  Option = LAlt (!), Command = LWin (#)
; ==============================================================================

; --- Word Navigation (Option + Left/Right) ---
!Left::Send("^{Left}")
!Right::Send("^{Right}")

; --- Word Deletion (Option + Backspace / Delete) ---
!Backspace::Send("^{Backspace}")
!Delete::Send("^{Delete}")

; --- Line Navigation (Command + Left/Right) ---
#Left::Send("{Home}")
#Right::Send("{End}")

; --- Document Top / Bottom (Command + Up/Down) ---
#Up::Send("^{Home}")
#Down::Send("^{End}")

; --- Word Selection (Option + Shift + Left/Right) ---
!+Left::Send("^+{Left}")
!+Right::Send("^+{Right}")

; --- Line Selection (Command + Shift + Left/Right) ---
#+Left::Send("+{Home}")
#+Right::Send("+{End}")

; --- Document Selection (Command + Shift + Up/Down) ---
#+Up::Send("^+{Home}")
#+Down::Send("^+{End}")
