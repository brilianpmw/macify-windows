# Phase 3: Target Experience Specification

This document details the functional behavior, keyboard mappings, and exception handling for the macOS-to-Windows transition.

---

## 1. Physical Keyboard Layout Strategy

### Hardware Setup
You have an **Apple Magic Keyboard** (VID: `05AC`, PID: `024F`) connected via Bluetooth alongside standard USB input.

### Physical Key Equivalencies on Windows:
| Key on Apple Keyboard | Windows Virtual Key | AHK Modifier Symbol | Intended macOS Role |
| :--- | :--- | :--- | :--- |
| **Command (⌘)** | `LWin` (`vk5B`) | `#` | Primary modifier for shortcuts (`Cmd`) |
| **Option (⌥)** | `LAlt` (`vkA4`) | `!` | Word-by-word jumps, symbol alternate |
| **Control (⌃)** | `LCtrl` (`vkA2`) | `^` | Unix / Terminal interrupts (`SIGINT`) |

> [!NOTE]
> Because the Apple Keyboard sends `LWin` for the physical Command key, mapping `LWin` shortcuts directly maps your physical thumb position to the identical Mac location!
> If you also use a standard Windows keyboard, the script can support either physical layout.

---

## 2. Core Shortcut Mapping Table

| macOS Action | Physical Mac Combination | Windows Action Triggered | Implementation Notes |
| :--- | :--- | :--- | :--- |
| **Copy** | `Cmd + C` | `Ctrl + C` | Standard clipboard copy |
| **Paste** | `Cmd + V` | `Ctrl + V` | Standard clipboard paste |
| **Cut** | `Cmd + X` | `Ctrl + X` | Standard clipboard cut |
| **Undo** | `Cmd + Z` | `Ctrl + Z` | Undo last action |
| **Redo** | `Cmd + Shift + Z` | `Ctrl + Y` or `Ctrl + Shift + Z` | Redo action |
| **Select All** | `Cmd + A` | `Ctrl + A` | Select all text/items |
| **Save** | `Cmd + S` | `Ctrl + S` | Save file/document |
| **Find** | `Cmd + F` | `Ctrl + F` | Find in page/file |
| **Close Tab** | `Cmd + W` | `Ctrl + W` (or `Ctrl + F4`) | Closes active tab or window |
| **Quit App** | `Cmd + Q` | `Alt + F4` | Gracefully closes the active app |
| **New Tab** | `Cmd + T` | `Ctrl + T` | Opens new tab in browser/terminal |
| **App Switcher** | `Cmd + Tab` | `Alt + Tab` (Task Switcher) | Fluid app switching |
| **Spotlight** | `Cmd + Space` | Trigger Launcher (Flow/PowerToys) | macOS search overlay |
| **Region Screenshot** | `Cmd + Shift + 4` | `Win + Shift + S` | Snipping Tool region capture |
| **Full Screenshot** | `Cmd + Shift + 3` | `PrintScreen` | Captures entire screen |

---

## 3. macOS Text Navigation & Editing Shortcuts

On macOS, text navigation uses **Option** for words and **Command** for lines:

| macOS Action | Mac Shortcut | Windows Equivalent | Expected Behavior |
| :--- | :--- | :--- | :--- |
| **Word Left** | `Option + Left` | `Ctrl + Left` | Move cursor one word to the left |
| **Word Right** | `Option + Right` | `Ctrl + Right` | Move cursor one word to the right |
| **Delete Word Back** | `Option + Backspace` | `Ctrl + Backspace` | Delete the preceding word |
| **Line Start** | `Cmd + Left` | `Home` | Move cursor to start of line |
| **Line End** | `Cmd + Right` | `End` | Move cursor to end of line |
| **Select Word Left** | `Option + Shift + Left` | `Ctrl + Shift + Left` | Select previous word |
| **Select Word Right**| `Option + Shift + Right`| `Ctrl + Shift + Right`| Select next word |
| **Select to Line Start**| `Cmd + Shift + Left` | `Shift + Home` | Select to start of line |
| **Select to Line End** | `Cmd + Shift + Right`| `Shift + End` | Select to end of line |
| **Doc Top / Bottom** | `Cmd + Up / Down` | `Ctrl + Home / End` | Jump to beginning / end of document |

---

## 4. Application-Specific Exceptions

### Terminal Applications (`WindowsTerminal.exe`, `cmd.exe`, `powershell.exe`)
* **Problem:** In Linux/macOS terminals, `Ctrl + C` sends `SIGINT` (break running script/process). In Windows, users often accidentally kill processes when trying to copy.
* **Mac Solution:**
  * `Cmd + C` performs **Copy** (Sends `Ctrl + Shift + C` in Windows Terminal).
  * `Cmd + V` performs **Paste** (Sends `Ctrl + Shift + V` in Windows Terminal).
  * `Ctrl + C` is **untouched** and sends `SIGINT` to the shell.
  * `Ctrl + D` is **untouched** (sends EOF/exit).

### Code Editors (`Code.exe` - Visual Studio Code)
* Multi-cursor and line manipulation shortcuts must not collide with standard AHK overrides.
* `Cmd + P` sends `Ctrl + P` (Quick Open file).
* `Cmd + Shift + P` sends `Ctrl + Shift + P` (Command Palette).
* `Cmd + /` sends `Ctrl + /` (Toggle line comment).
* `Cmd + [` / `Cmd + ]` sends `Ctrl + [` / `Ctrl + ]` (Outdent / Indent).

### Web Browsers (`chrome.exe`, `msedge.exe`, `firefox.exe`, `brave.exe`)
* `Cmd + L` sends `Ctrl + L` (Focus address bar).
* `Cmd + R` sends `Ctrl + R` (Reload page).
* `Cmd + Shift + R` sends `Ctrl + Shift + R` (Hard reload).
* `Cmd + [` and `Cmd + ]` sends `Alt + Left` and `Alt + Right` (History Back / Forward).

---

## 5. Gaming Mode & Temporary Disable Mechanism

Because you play games via Steam:
* Games frequently use `Alt`, `Shift`, `Ctrl`, and the Windows key for movement, crouching, abilities, or overlays.
* **Solution:**
  * Global Hotkey: `Pause` / `ScrollLock` or `Cmd + Shift + G` to instantly toggle **Gaming Mode** (suspending all keyboard hooks).
  * A discreet system tray icon indicates when Macify is active vs paused.
