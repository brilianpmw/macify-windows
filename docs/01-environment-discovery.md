# Phase 1: Environment Discovery Report

**Generated on:** 2026-10-24
**Host Machine Target:** Windows PC

---

## 1. Operating System Details
* **OS Edition:** Microsoft Windows 11 Pro 64-bit
* **Version / Build:** `10.0.26200` (Build 26200 - Windows 11 24H2 / Canary/Insider branch)
* **Architecture:** 64-bit (x64)
* **Active Display:** Single Monitor, 1920x1080 resolution at 100% DPI scale

> [!NOTE]
> Windows Build 26200 is an advanced Windows 11 build (24H2). System-level hooks that patch internal explorer DLLs or DWM (such as old UXTheme patchers or invasive window-button injectors) are at high risk of crashing DWM or causing bootloops on this build. Non-invasive userland tools (AHK v2, WinGet, Tauri/WebView2 overlays) are strongly preferred.

---

## 2. Keyboard & Input Hardware Discovery
* **Active Languages / Input Locales:**
  * `en-US` (English United States - Layout: `00000409`)
  * `en-ID` (English Indonesia)
* **Connected Physical Keyboards:**
  1. **Apple Bluetooth Device:**
     * **Hardware ID:** `HID\{00001124-0000-1000-8000-00805F9B34FB}_VID&000205AC_PID&024F`
     * **Vendor:** `05AC` (Apple Inc.)
     * **Model:** Apple Magic Keyboard (Bluetooth)
  2. **Standard USB / HID Keyboard Controller:**
     * **Hardware ID:** `HID\VID_2717&PID_5094`
* **Hardware Layout Implications:**
  * When an **Apple Magic Keyboard** is connected to Windows:
    * The physical key labeled **Command (⌘)** is mapped by Windows HID driver as the **Windows Key (`LWin`)**.
    * The physical key labeled **Option (⌥)** is mapped by Windows HID driver as the **Alt Key (`LAlt`)**.
    * The physical key labeled **Control (⌃)** is mapped by Windows HID driver as **Control (`LCtrl`)**.
  * Your natural Mac thumb rests on **Command** (`LWin`), expecting it to act as `Cmd + C`, `Cmd + V`, `Cmd + Tab`, `Cmd + Space`, etc.
  * Your thumb/finger resting on **Option** (`LAlt`) expects word-by-word jumping and word deletion (`Option + Left/Right`, `Option + Backspace`).

---

## 3. Installed Developer & System Tools
| Tool | Detected Status | Path / Version |
| :--- | :--- | :--- |
| **Git** | Installed | `C:\Program Files\Git\cmd\git.exe` |
| **Windows Terminal** | Installed | Version `1.24.12741.0` |
| **VS Code** | Installed | `C:\Users\brili\AppData\Local\Programs\Microsoft VS Code\bin\code.cmd` |
| **WinGet (Package Manager)**| Installed | `C:\Users\brili\AppData\Local\Microsoft\WindowsApps\winget.exe` |
| **PowerShell** | Installed | Windows PowerShell 5.1 (Build 26100.9711) |
| **AutoHotkey** | Not installed | Available via WinGet (`AutoHotkey.AutoHotkey` v2.0.30) |
| **PowerToys** | Not installed | Available via WinGet |
| **Windhawk** | Not installed | Available via official installer |

---

## 4. Desktop & Shell Configuration
* **Taskbar:** Standard Windows 11 taskbar, auto-hide is off.
* **Explorer Shell:** Default Windows 11 explorer with modern XAML/WinUI tabs.

---

## 5. Potential Conflicts & Running Workflows
* **Gaming Software:** **Steam** (`steam.exe`, `steamservice.exe`, `steamwebhelper.exe`) is actively running.
  * *Critical requirement:* Keyboard remapping must have an instant toggle (Gaming Mode / Pause) so that `LWin`, `Alt`, and `Ctrl` remappings do not interfere with in-game keybindings or trigger anti-cheat software (like Vanguard or Easy Anti-Cheat).
* **Terminal Workflow:** Windows Terminal runs PowerShell / WSL / Git Bash. Terminal shortcuts like `Ctrl + C` (SIGINT break) must be preserved while still allowing `Cmd + C` (Copy) and `Cmd + V` (Paste).
* **Editor Workflow:** VS Code has built-in multi-cursor, word navigation, and line hopping. The remapping script must respect VS Code's editor shortcuts without double-triggering.
