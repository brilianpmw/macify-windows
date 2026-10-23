# Phase 2: Open-Source Project Research Report

This document evaluates candidate open-source tools for transforming Windows 11 into a macOS-like environment.

---

## A. Kinto (`rbreaves/kinto`)
* **Repository:** [https://github.com/rbreaves/kinto](https://github.com/rbreaves/kinto)
* **Website:** [https://kinto.sh](https://kinto.sh)
* **Primary Purpose:** Replicate macOS keyboard shortcuts across Windows and Linux using application-specific logic.

### Technical Evaluation
| Criteria | Findings |
| :--- | :--- |
| **Windows 11 Compatibility** | Supported, but can be brittle on cutting-edge builds (Windows 11 Build 26200+). |
| **Maintenance Activity** | Maintained, but updates to the Windows installer have been slower than Linux. |
| **Underlying Engine** | AutoHotkey v1.1 + Python + Chocolatey package manager. |
| **Installation Requirements** | Requires running an automated PowerShell script with elevated Administrator privileges, installing Chocolatey, Python, and deprecated AutoHotkey v1. |
| **Limitations & Known Issues** | 1. **Deprecated AHK v1:** AutoHotkey v1 is officially end-of-life; modern community development is on AHK v2.<br>2. **Bloat / Dependency Chain:** Requires full Chocolatey and Python runtimes just for keyboard remapping.<br>3. **High Privilege Requirement:** Incompatible with standard user execution.<br>4. **Git Sync Difficulty:** Configuration is placed across `~/.kinto`, registry, and system paths, making it hard to synchronize in a single Git repo. |
| **Coexistence** | Can conflict with other AHK scripts or low-level keyboard hooks if multiple hooks compete for key intercepts. |

> [!IMPORTANT]
> **Verdict on Kinto:** While Kinto's key-remapping concepts and logic tables are brilliant, its installer relies on legacy AHK v1, Python, and Chocolatey. We can directly adapt Kinto's application-aware rules into a clean, zero-dependency, modern **AutoHotkey v2 script** (`Macify.ahk`) maintained directly within your `macify-windows` Git repository. This achieves identical Mac muscle memory without system bloat or security risks.

---

## B. Seelen UI (`eythaann/Seelen-UI`)
* **Repository:** [https://github.com/eythaann/Seelen-UI](https://github.com/eythaann/Seelen-UI)
* **Primary Purpose:** Comprehensive macOS-inspired desktop replacement overlay (Dock, Top Bar, App Launcher, Tiling Window Manager).

### Technical Evaluation
| Criteria | Findings |
| :--- | :--- |
| **Windows 11 Compatibility** | **Excellent.** Actively developed specifically for Windows 11 (including 24H2 builds). |
| **Maintenance Activity** | Highly active (v2.8.8+ released recently). |
| **Architecture** | Built with **Rust + Tauri + WebView2**, ensuring high performance, minimal memory footprint (~70-120 MB RAM), and native Windows API integration. |
| **Installation Method** | Standard WinGet package (`winget install Seelen.SeelenUI`) or Microsoft Store. Does not require replacing `explorer.exe`. |
| **Desktop Components** | 1. **macOS-like Dock:** Bottom dock with magnification/bounce, running indicators, pinned apps.<br>2. **Top Bar:** macOS menu-bar aesthetic with clock, system status, volume, tray controls.<br>3. **Application Launcher:** Spotlight-style popup launcher.<br>4. **Window Tiling:** Optional tiling window manager (can be toggled off to keep standard floating windows). |
| **System Impact & Safety** | **100% Non-destructive.** Runs as a userland process. Can be closed, disabled, or uninstalled with zero system corruption. |

> [!TIP]
> **Verdict on Seelen UI:** Highly recommended for desktop layout (Dock & Top Bar). It delivers the exact macOS aesthetic without invasive shell modifications.

---

## C. Windhawk (`windhawk.net`) & Window Controls
* **Website:** [https://windhawk.net/](https://windhawk.net/)
* **Primary Purpose:** Modular customization engine for Windows programs and system components using lightweight C++ hooks.

### Investigation of Traffic-Light Window Controls (Red/Yellow/Green Buttons on Top-Left)
* **Desired Behavior:** Moving window caption buttons to the upper-left and rendering macOS-style traffic lights.
* **Findings on Current Feasibility:**
  * **No universal, stable mod exists** for Windows 11 Build 26200 that moves caption buttons to the left across all windows.
  * **Why?** In modern Windows 11, application windows are rendered by at least three completely different graphics frameworks:
    1. **WinUI 3 / XAML** (Windows Terminal, modern File Explorer, Settings): Caption buttons are drawn inside the app's own client canvas, not by the legacy DWM non-client frame.
    2. **Chromium / Electron** (VS Code, Chrome, Discord, Slack, Spotify): These apps draw completely custom HTML/CSS titlebars.
    3. **Classic Win32 / WPF** (e.g., 7-Zip, Notepad++, Task Manager): Handled by DWM.
  * Attempting to force left-aligned buttons via DLL injection on Windows 11 Build 26200 (Canary/24H2) breaks tabbed interfaces (tabs collide with buttons), causes phantom hitboxes, and risks Explorer/DWM crashes.
* **What Windhawk CAN reliably do for macOS feel:**
  * **MacOS Minimize Animation (Genie Effect):** Available on Windhawk (`MacOS Minimize Animation` mod). Safely animates windows into the dock/taskbar without altering title bars.
  * **Taskbar Styler / Clock customization.**

> [!WARNING]
> **Honest Limitation:** Reordering native caption buttons to the top-left cannot be universally implemented without sacrificing stability. As instructed, we will not deploy decorative dummy buttons that break window controls. Applications like VS Code can natively style their title bars cleanly.

---

## D. Additional Candidate Projects

### 1. Spotlight Search: Flow Launcher (`Flow-Launcher/Flow-Launcher`)
* **Repository:** [https://github.com/Flow-Launcher/Flow-Launcher](https://github.com/Flow-Launcher/Flow-Launcher)
* **Purpose:** Modern, lightning-fast application launcher and system search.
* **macOS Theme:** Community theme `cc46808/macOS.flow` replicates the rounded, blurred macOS Spotlight aesthetic.
* **Shortcut:** Configurable to trigger on `Cmd + Space` (`LWin + Space` or `Alt + Space`).
* **Package:** `winget install Flow-Launcher.Flow-Launcher`.

### 2. macOS Application Switching: `cmdtab` / `AltAppSwitcher`
* **Repositories:** [stianhoiland/cmdtab](https://github.com/stianhoiland/cmdtab) / [hdlx/AltAppSwitcher](https://github.com/hdlx/AltAppSwitcher)
* **Purpose:** macOS-style application switcher where `Cmd + Tab` switches between distinct *applications* rather than every individual window, and `Cmd + ~` (tilde) switches between windows of the active app.
* **Alternative:** Native Windows Alt+Tab remapping via AutoHotkey v2 (low resource, zero additional processes).

### 3. Native Screenshots
* macOS `Cmd + Shift + 4` (Region Screenshot) $\rightarrow$ Windows Snipping Tool (`Win + Shift + S`).
* macOS `Cmd + Shift + 3` (Fullscreen Screenshot) $\rightarrow$ Windows PrintScreen / `Win + PrintScreen`.
* Can be flawlessly remapped in AutoHotkey v2.
