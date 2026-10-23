# Macify Windows 🍎

> Transform Windows 11 into a macOS-like desktop environment prioritizing muscle-memory fidelity, developer workflows, and 100% stability.

Designed for Mac users working on Windows PCs and laptops without fighting keyboard shortcuts or breaking gaming performance.

---

## ⚡ Quick Start

Clone or copy this repository to any Windows machine:

```powershell
# 1. Open PowerShell
cd c:\Users\brili\OneDrive\Documents\macify-windows

# 2. Run the automated installer (installs AutoHotkey v2 via winget and enables startup)
.\scripts\install.ps1

# Optional: To also install the macOS Dock & Top Bar (Seelen UI) and Spotlight Search (Flow Launcher):
.\scripts\install.ps1 -WithSeelenUI -WithFlowLauncher
```

---

## 📂 Repository Structure

```text
macify-windows/
├── README.md                          # Quick start & project documentation
├── configs/
│   └── autohotkey/
│       └── Macify.ahk                 # Core AHK v2 keyboard engine
├── scripts/
│   ├── install.ps1                    # 1-click automated setup
│   ├── uninstall.ps1                  # 1-click complete rollback to Windows defaults
│   └── toggle-gaming-mode.ps1         # Quick command to pause/resume remapping
└── docs/
    ├── 01-environment-discovery.md    # Windows 11 & hardware discovery report
    ├── 02-project-research.md         # In-depth analysis of Kinto, Seelen UI, Windhawk
    ├── 03-target-experience.md        # Full shortcut and text-navigation spec
    ├── 04-architecture-plan.md        # Technical architecture & reversibility plan
    ├── 05-keyboard-reference.md       # Complete shortcut cheat sheet
    └── 06-testing-and-verification.md # Step-by-step verification checklist
```

---

## ⌨️ Supported macOS Shortcuts

| macOS Shortcut | Windows Action | Description |
| :--- | :--- | :--- |
| **`Cmd + C`** | Copy | Standard copy (and Terminal copy without SIGINT) |
| **`Cmd + V`** | Paste | Standard paste |
| **`Cmd + X`** | Cut | Cut selected text |
| **`Cmd + Z` / `Shift + Z`**| Undo / Redo | Standard undo / redo |
| **`Cmd + A` / `Cmd + S`**| Select All / Save | Document operations |
| **`Cmd + W` / `Cmd + Q`**| Close / Quit | Close tab or quit application |
| **`Cmd + Shift + 4`** | Region Screenshot | Triggers Snipping Tool selection |
| **`Cmd + Shift + 3`** | Fullscreen Capture | Instant full screenshot |
| **`Option + Left / Right`**| Word Navigation | Jump word-by-word |
| **`Option + Backspace`** | Delete Word | Delete entire preceding word |
| **`Cmd + Left / Right`** | Line Jump | Jump to start / end of line (`Home` / `End`) |
| **`Cmd + Shift + Left/Right`**| Line Select | Highlight to start / end of line |
| **`Cmd + Tab`** | App Switcher | Switch between active applications |
| **`Cmd + Space`** | Spotlight | Opens search / app launcher |
| **`Ctrl + Shift + G`** | **Gaming Mode** | **Instant toggle to suspend/resume all mappings** |

---

## 🛠️ Components & Architecture

1. **Keyboard Engine (`configs/autohotkey/Macify.ahk`):**
   * Written in modern **AutoHotkey v2**.
   * Specifically tailored for **Apple Magic Keyboards** (where Command sends `LWin` and Option sends `LAlt`) as well as standard PC keyboards.
   * Context-aware: protects terminal `Ctrl + C` (SIGINT) while enabling `Cmd + C` / `Cmd + V`.
2. **macOS Dock & Top Bar ([Seelen UI](https://github.com/eythaann/Seelen-UI)):**
   * Non-invasive Rust/Tauri desktop overlay providing a floating dock and status bar.
3. **Spotlight Search ([Flow Launcher](https://github.com/Flow-Launcher/Flow-Launcher)):**
   * Extensible launcher styled with macOS Spotlight themes.

---

## 🛡️ Stability, Safety & Honest Limitations

* **No invasive DLL injections:** We intentionally avoid unverified patches that attempt to force traffic-light buttons on the upper-left of Windows title bars, as modern Windows 11 apps (WinUI 3, Electron, XAML) draw custom client-side decorations that crash or misalign when hooked.
* **100% Reversible:** Run `.\scripts\uninstall.ps1` at any time to remove all shortcuts and restore vanilla Windows defaults.
* **Gaming Safe:** `Ctrl + Shift + G` pauses all hooks so games like Steam, Riot, and anti-cheat programs run without conflict.

---

## 🚀 Push to Your GitHub

To push this project to your GitHub account:

```powershell
cd c:\Users\brili\OneDrive\Documents\macify-windows
git add .
git commit -m "feat: initial release of Macify Windows setup"

# Add your GitHub remote repository (replace with your repo URL):
# git remote add origin https://github.com/<your-username>/macify-windows.git
# git branch -M main
# git push -u origin main
```
