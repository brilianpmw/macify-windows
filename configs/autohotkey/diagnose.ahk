#Requires AutoHotkey v2.0
#SingleInstance Force
InstallKeybdHook(true, true)
Persistent

; ==============================================================================
;  Macify Windows 🍎 - Diagnostic & Live Keyboard Tester
; ==============================================================================

myGui := Gui("+AlwaysOnTop", "Macify Keyboard Diagnostic 🍎")
myGui.SetFont("s10", "Segoe UI")

myGui.Add("Text", "w450", "Press any key on your keyboard (Command, Option, C, V, 4, etc.) to see what Windows detects in real time:")

editLog := myGui.Add("Edit", "w450 r10 ReadOnly", "Waiting for keypress...`n")

btnSnip := myGui.Add("Button", "w220", "Test Screenshot (Snipping Tool)")
btnSnip.OnEvent("Click", (*) => Run("ms-screenclip:"))

btnCopy := myGui.Add("Button", "x+10 w220", "Test Copy / Paste")
btnCopy.OnEvent("Click", (*) => MsgBox("Clipboard currently holds: `n" . A_Clipboard))

myGui.Show("w480 h340")

; --- Hook All Modifier Keys & Shortcuts ---
LogKey(keyName) {
    global editLog
    timestamp := FormatTime(, "HH:mm:ss")
    editLog.Value := timestamp . " -> DETECTED: " . keyName . "`n" . editLog.Value
}

; Test Global Intercepts
~*LWin::LogKey("Left Windows Key (Physical Command on Apple Keyboard)")
~*RWin::LogKey("Right Windows Key")
~*LAlt::LogKey("Left Alt Key (Physical Option or PC Alt)")
~*RAlt::LogKey("Right Alt Key")
~*LCtrl::LogKey("Left Control Key")

; Test Copy / Paste / Screenshot Intercepts
$#c:: {
    LogKey("[HOTKEY FIRED] Cmd+C (Win+C) -> Sent Ctrl+C")
    Send("^c")
}

$!c:: {
    LogKey("[HOTKEY FIRED] Alt+C -> Sent Ctrl+C")
    Send("^c")
}

$#v:: {
    LogKey("[HOTKEY FIRED] Cmd+V (Win+V) -> Sent Ctrl+V")
    Send("^v")
}

$!v:: {
    LogKey("[HOTKEY FIRED] Alt+V -> Sent Ctrl+V")
    Send("^v")
}

$#+4:: {
    LogKey("[HOTKEY FIRED] Cmd+Shift+4 -> Triggering Snipping Tool")
    Run("ms-screenclip:")
}

$!+4:: {
    LogKey("[HOTKEY FIRED] Alt+Shift+4 -> Triggering Snipping Tool")
    Run("ms-screenclip:")
}

$^+4:: {
    LogKey("[HOTKEY FIRED] Ctrl+Shift+4 -> Triggering Snipping Tool")
    Run("ms-screenclip:")
}
