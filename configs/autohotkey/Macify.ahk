#Requires AutoHotkey v2.0
#SingleInstance Force
Persistent

; ==============================================================================
;  PROJECT: Macify Windows 🍎
;  File: Macify.ahk (AutoHotkey v2 Core Keyboard Engine - Production)
; ==============================================================================

; --- Mask Start Menu so pressing Win key as Cmd never opens Start Menu ---
A_MenuMaskKey := "vkE8"

; --- Tray Configuration ---
A_IconTip := "Macify Windows (Active)"
TraySetIcon("shell32.dll", 44) ; Star icon

; --- Global State ---
global isSuspended := false

; --- Tray Menu ---
A_TrayMenu.Delete()
A_TrayMenu.Add("Macify Windows v1.2", (*) => Run("https://github.com/brilianpmw/macify-windows"))
A_TrayMenu.Disable("Macify Windows v1.2")
A_TrayMenu.Add() ; Separator
A_TrayMenu.Add("Toggle Gaming Mode (Ctrl+Shift+G)", ToggleSuspend)
A_TrayMenu.Add("Reload Script", (*) => Reload())
A_TrayMenu.Add("Exit", (*) => ExitApp())

; ------------------------------------------------------------------------------
;  HOTKEY: Toggle Gaming Mode (Ctrl+Shift+G)
; ------------------------------------------------------------------------------
^+g::ToggleSuspend()

ToggleSuspend(*) {
    global isSuspended
    isSuspended := !isSuspended
    Suspend(isSuspended)
    if (isSuspended) {
        A_IconTip := "Macify Windows (PAUSED - Gaming Mode)"
        ToolTip("Macify: Gaming Mode (Shortcuts Paused)")
    } else {
        A_IconTip := "Macify Windows (Active)"
        ToolTip("Macify: macOS Shortcuts Active!")
    }
    SetTimer(() => ToolTip(), -2000)
}

; ==============================================================================
;  SECTION 1: TERMINAL APPLICATIONS
;  Protect Ctrl+C as SIGINT, while Cmd+C / Alt+C copies
; ==============================================================================
GroupAdd("Terminals", "ahk_exe WindowsTerminal.exe")
GroupAdd("Terminals", "ahk_exe wt.exe")
GroupAdd("Terminals", "ahk_exe cmd.exe")
GroupAdd("Terminals", "ahk_exe powershell.exe")
GroupAdd("Terminals", "ahk_exe bash.exe")

#HotIf WinActive("ahk_group Terminals")
#c::Send("^+c")
!c::Send("^+c")
#v::Send("^+v")
!v::Send("^+v")
#HotIf

; ==============================================================================
;  SECTION 2: SCREENSHOT SHORTCUTS (macOS Style)
;  Cmd + Shift + 4  -> Snipping Tool (Region Capture)
;  Cmd + Shift + 3  -> Fullscreen Screenshot
;  Cmd + Shift + 5  -> Snipping Tool / Screen Recording
; ==============================================================================
#+4::Send("#+s")
!+4::Send("#+s")
^+4::Send("#+s")

#+3::Send("{PrintScreen}")
!+3::Send("{PrintScreen}")
^+3::Send("{PrintScreen}")

#+5::Send("#+s")
!+5::Send("#+s")
^+5::Send("#+s")

; ==============================================================================
;  SECTION 3: CLIPBOARD & EDITING SHORTCUTS
;  Mapped to both Win (#) for Apple Keyboards and Alt (!) for PC Keyboards
; ==============================================================================
#c::Send("^c")
!c::Send("^c")

#v::Send("^v")
!v::Send("^v")

#x::Send("^x")
!x::Send("^x")

#a::Send("^a")
!a::Send("^a")

#z::Send("^z")
!z::Send("^z")

#+z::Send("^y")
!+z::Send("^y")

#s::Send("^s")
!s::Send("^s")

#f::Send("^f")
!f::Send("^f")

#t::Send("^t")
!t::Send("^t")

#w::Send("^w")
!w::Send("^w")

#q::Send("!{F4}")
!q::Send("!{F4}")

#m::Send("#{Down}")
!m::Send("#{Down}")

; --- Application Switching (Cmd + Tab) ---
#Tab::Send("!{Tab}")

; --- Spotlight Search (Cmd + Space) -> Opens Flow Launcher ---
#Space::Send("!{Space}")
!Space::Send("!{Space}")

; ==============================================================================
;  SECTION 4: TEXT NAVIGATION & EDITING (Option / Command Jumps)
; ==============================================================================
; Option + Left/Right -> Move cursor word-by-word
!Left::Send("^{Left}")
!Right::Send("^{Right}")

; Option + Backspace / Delete -> Delete word
!Backspace::Send("^{Backspace}")
!Delete::Send("^{Delete}")

; Command + Left/Right -> Move to start/end of line
#Left::Send("{Home}")
#Right::Send("{End}")

; Command + Up/Down -> Move to document top/bottom
#Up::Send("^{Home}")
#Down::Send("^{End}")

; Option + Shift + Left/Right -> Select word-by-word
!+Left::Send("^+{Left}")
!+Right::Send("^+{Right}")

; Command + Shift + Left/Right -> Select to line start/end
#+Left::Send("+{Home}")
#+Right::Send("+{End}")
