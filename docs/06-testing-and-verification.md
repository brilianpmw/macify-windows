# Phase 6: Testing & Verification Checklist

Use this checklist to verify that all macOS muscle memory shortcuts, developer workflows, and gaming overrides function as intended.

---

## 🧪 Verification Matrix

### 1. Clipboard & Document Basics
* [ ] **`Cmd + C` & `Cmd + V`**: Select text in Chrome or Notepad; press `Cmd + C` then `Cmd + V`. Text should paste correctly.
* [ ] **`Cmd + X`**: Cut text from an editor.
* [ ] **`Cmd + A`**: Select all text in active document.
* [ ] **`Cmd + Z` & `Cmd + Shift + Z`**: Undo and redo typing.
* [ ] **`Cmd + S`**: Triggers file save dialog.
* [ ] **`Cmd + F`**: Opens search / find dialog.

### 2. Screenshots
* [ ] **`Cmd + Shift + 4`**: Triggers Windows Snipping Tool overlay (rectangular selection tool).
* [ ] **`Cmd + Shift + 3`**: Takes instant full-screen screenshot to clipboard.

### 3. Text Navigation & Word Jumping
* [ ] **`Option + Left / Right`**: Moves cursor word-by-word.
* [ ] **`Option + Backspace`**: Deletes preceding word (instead of single character).
* [ ] **`Cmd + Left / Right`**: Moves cursor to the start/end of the line.
* [ ] **`Cmd + Shift + Left / Right`**: Selects text to the start/end of the line.
* [ ] **`Cmd + Up / Down`**: Jumps to the top/bottom of document.

### 4. Terminal Application Safety
* [ ] Open **Windows Terminal** (`wt.exe` or PowerShell).
* [ ] Run a continuous command (e.g., `ping 1.1.1.1 -t`).
* [ ] Press **`Ctrl + C`**: Confirm that `Ctrl + C` sends `SIGINT` and halts the ping process.
* [ ] Highlight text and press **`Cmd + C`**: Confirm it copies text without terminating running commands.
* [ ] Press **`Cmd + V`**: Confirm text pastes into the prompt.

### 5. Code Editor (VS Code)
* [ ] Open **VS Code**.
* [ ] Press **`Cmd + P`**: Quick Open file palette opens.
* [ ] Press **`Cmd + Shift + P`**: Command Palette opens.
* [ ] Press **`Cmd + /`**: Toggles line comment.
* [ ] Press **`Cmd + [` / `Cmd + ]`**: Indents / Outdents code.

### 6. Window Lifecycle & App Switching
* [ ] **`Cmd + W`**: Closes current browser tab or window.
* [ ] **`Cmd + Q`**: Closes active application (equivalent to `Alt + F4`).
* [ ] **`Cmd + M`**: Minimizes current window.
* [ ] **`Cmd + Tab`**: Opens Windows Task Switcher and smoothly cycles apps.

### 7. Gaming Mode & Suspension
* [ ] Press **`Ctrl + Shift + G`**: Discreet tooltip confirms "Gaming Mode Enabled".
* [ ] Test pressing `LWin` or `Alt`: Default Windows / game behavior is active.
* [ ] Press **`Ctrl + Shift + G`** again: "macOS Shortcuts Active" re-engages.

### 8. System Startup & Persistence
* [ ] Verify shortcut exists in `%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\MacifyWindows.lnk`.
* [ ] After restarting or re-logging into Windows, confirm the Macify icon appears in the system tray and shortcuts are active.
