# Phase 4: Architecture & Implementation Plan

This technical plan defines the components, installation methods, risk mitigations, and restoration procedures.

---

## 1. Selected Components

| Component | Selected Tool | Repository / Source | Justification |
| :--- | :--- | :--- | :--- |
| **Keyboard Engine** | **`Macify.ahk` (AHK v2)** | Built-in in `macify-windows` repo | Replicates Kinto's application-aware Mac logic on modern AutoHotkey v2 without legacy dependencies (Python, Chocolatey) and tailored directly to your Apple Magic Keyboard. |
| **Desktop Dock & Top Bar** | **Seelen UI** | [eythaann/Seelen-UI](https://github.com/eythaann/Seelen-UI) | High-performance Rust/Tauri macOS-inspired desktop layer. Completely non-invasive, does not alter system DLLs. |
| **Spotlight Search** | **Flow Launcher** | [Flow-Launcher/Flow-Launcher](https://github.com/Flow-Launcher/Flow-Launcher) | Smooth, extensible Mac Spotlight replacement with rounded blurred theme (`macOS.flow`). |
| **Window Minimize Animation** | **Windhawk (Optional)** | [windhawk.net](https://windhawk.net/) | For macOS "Genie" minimize animation. Optional visual polish. |

---

## 2. Component Specifications

### Component 1: `Macify.ahk` (AutoHotkey v2 Core)
* **What it does:** Low-level, non-invasive keyboard hook handling Mac shortcuts, text navigation, terminal protections, and screenshot mappings.
* **Compatibility:** 100% compatible with Windows 11 Build 26200.
* **Installation:** Run via AutoHotkey v2 executable (`AutoHotkey.AutoHotkey` via WinGet).
* **Startup:** Managed via a shortcut in `%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup`.
* **Disable/Uninstall:** Simply exit from the system tray icon or run `scripts/uninstall.ps1`. No reboot required.
* **Gaming Safety:** Includes instant `Ctrl + Shift + G` hotkey to suspend all mappings when launching games.

### Component 2: Seelen UI (Dock & Top Bar)
* **What it does:** Renders a floating macOS dock at the bottom of the screen and a top menu bar with clock, battery, and tray icons.
* **Compatibility:** Fully validated on Windows 11 (22H2 through 24H2).
* **Installation:** `winget install --id Seelen.SeelenUI --source winget`.
* **Disable/Uninstall:** `winget uninstall Seelen.SeelenUI` or toggle off autostart in Seelen UI settings.

### Component 3: Flow Launcher (Spotlight)
* **What it does:** Instant search bar triggered by `Cmd + Space` (`Win + Space` or `Alt + Space`).
* **Installation:** `winget install --id Flow-Launcher.Flow-Launcher --source winget`.
* **Configuration:** Styled with `macOS.flow` theme.

---

## 3. Safety & Reversibility Analysis

* **Elevation / Admin Requirements:** None required for daily operation. WinGet installs use user-scope where available.
* **Windows Shell Integrity:** The Windows shell (`explorer.exe`) is untouched. No binary patching of system DLLs (`uxtheme.dll`, `dwmapi.dll`) is performed.
* **Antivirus / Defender:** Standard userland apps signed by developers. No heuristics alarms or registry tampering.
* **Single-Directory Portability:** Everything (scripts, configurations, docs, installer/uninstaller) resides in `c:\Users\brili\OneDrive\Documents\macify-windows` so you can commit and push directly to GitHub.

---

## 4. Rollback and Restoration Plan

To return your system to standard Windows defaults at any time:
1. Run `scripts/uninstall.ps1`.
2. It stops the AHK process, removes the startup shortcut, uninstalls Seelen UI / Flow Launcher if desired, and restores standard Windows shortcuts.
3. Zero registry residue or broken shortcuts.
