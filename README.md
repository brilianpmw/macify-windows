# Macify Windows 🍎✨

<div align="center">

![Windows 11](https://img.shields.io/badge/Windows-11%20%2824H2%20Ready%29-0078D6?style=for-the-badge&logo=windows&logoColor=white)
![macOS Experience](https://img.shields.io/badge/UX-macOS%20Fidelity-000000?style=for-the-badge&logo=apple&logoColor=white)
![AutoHotkey v2](https://img.shields.io/badge/Engine-AutoHotkey%20v2-334455?style=for-the-badge&logo=autohotkey&logoColor=white)
![Zero Bloat](https://img.shields.io/badge/Stability-100%25%20Reversible-2ea44f?style=for-the-badge)
![License](https://img.shields.io/badge/License-MIT-blue?style=for-the-badge)

**Transform your Windows PC into a true macOS desktop experience.**  
*Eliminate muscle-memory conflicts, keep terminal `Ctrl+C` safe, take Mac-style screenshots, and enjoy seamless gaming compatibility.*

[Quick Start](#-quick-start) • [Shortcuts Cheat Sheet](#-keyboard-shortcuts-cheat-sheet) • [Tutorial](#-user-tutorial--features) • [Backup & Rollback](#-automatic-backup--safe-rollback) • [Multi-PC Setup](#-portable-setup-for-your-other-pcs)

</div>

---

## 🌟 Why Macify Windows?

If you use a **MacBook for work** and a **Windows PC for personal projects, development, and gaming**, you know the agony:
* Constantly pressing `Ctrl` instead of `Cmd`, breaking your flow.
* Trying to take an area screenshot with `Cmd + Shift + 4` and getting nothing.
* Trying to copy from a terminal and accidentally killing your running server (`SIGINT`).
* Breaking in-game controls because of clunky global remapping tools.

**Macify Windows** solves all of this with a lightweight, non-invasive architecture built on modern **AutoHotkey v2**, **Seelen UI**, and **Flow Launcher**.

```
                ┌──────────────────────────────────────────────┐
                │          Macify Windows 🍎 Stack             │
                ├──────────────────────────────────────────────┤
                │  ⌨️  Macify.ahk (Pure AHK v2 Engine)         │
                │     ├─ Clipboard: Cmd+C, V, X, Z, A, S, F    │
                │     ├─ Screenshots: Cmd+Shift+4 / 3 / 5      │
                │     ├─ Text Jump: Option+◄/►, Cmd+◄/►        │
                │     ├─ Terminal Safe: Ctrl+C SIGINT intact   │
                │     └─ Gaming Mode: Ctrl+Shift+G Pause       │
                ├──────────────────────────────────────────────┤
                │  🌊  Flow Launcher (Spotlight Cmd+Space)     │
                │  🖥️  Seelen UI (macOS Dock & Top Bar)        │
                │  💾  Automated Pre-Install Backups           │
                └──────────────────────────────────────────────┘
```

---

## ⚡ Quick Start

Setting up takes under 60 seconds using PowerShell:

```powershell
# 1. Clone the repository
git clone https://github.com/brilianpmw/macify-windows.git
cd macify-windows

# 2. Run the automated installer
# Automatically creates a pre-install backup and launches Macify:
.\scripts\install.ps1

# (Recommended) To include macOS Dock, Top Bar, and Spotlight Search:
.\scripts\install.ps1 -WithSeelenUI -WithFlowLauncher
```

---

## ⌨️ Keyboard Shortcuts Cheat Sheet

Works seamlessly with **Apple Magic Keyboards** (Bluetooth/USB) and **Standard PC Keyboards**:

### 📋 Clipboard & System Operations
| macOS Shortcut | Windows Action | Description |
| :--- | :--- | :--- |
| **`Cmd + C`** | Copy | Copies selection without moving your thumb to `Ctrl` |
| **`Cmd + V`** | Paste | Pastes clipboard contents |
| **`Cmd + X`** | Cut | Cuts selection |
| **`Cmd + A`** | Select All | Selects all text or items |
| **`Cmd + Z`** | Undo | Reverts previous action |
| **`Cmd + Shift + Z`** | Redo | Redoes undone action |
| **`Cmd + S`** | Save | Saves active document |
| **`Cmd + F`** | Find | Opens in-page find bar |
| **`Cmd + W`** | Close Tab / Window | Closes active browser tab or document (`Ctrl + W`) |
| **`Cmd + Q`** | Quit Application | Gracefully closes active program (`Alt + F4`) |
| **`Cmd + Tab`** | App Switcher | Cycles through open applications |
| **`Cmd + Space`** | **Spotlight Search** | Opens rounded blurred macOS Spotlight search |

### 📸 macOS Screenshots
| macOS Shortcut | Windows Action | Description |
| :--- | :--- | :--- |
| **`Cmd + Shift + 4`** | **Region Snip** | Drag a rectangle to screenshot to clipboard |
| **`Cmd + Shift + 3`** | **Fullscreen Snip** | Instantly captures entire display to clipboard |
| **`Cmd + Shift + 5`** | **Screen Tool** | Opens interactive snip & screen-recording toolbar |

### 🔤 Text Navigation (Word & Line Jumping)
| macOS Shortcut | Windows Equivalent | Description |
| :--- | :--- | :--- |
| **`Option + Left / Right`** | `Ctrl + Left / Right` | Move cursor word-by-word |
| **`Option + Backspace`** | `Ctrl + Backspace` | Delete entire preceding word |
| **`Option + Delete`** | `Ctrl + Delete` | Delete entire word forward |
| **`Cmd + Left / Right`** | `Home` / `End` | Jump to beginning / end of line |
| **`Cmd + Up / Down`** | `Ctrl + Home / End` | Jump to beginning / end of document |
| **`Option + Shift + Left/Right`** | `Ctrl + Shift + Left/Right` | Select word-by-word |
| **`Cmd + Shift + Left/Right`** | `Shift + Home / End` | Select to start / end of line |

---

## 🎓 User Tutorial & Features

### 1. Developer-Friendly Terminal Protection 💻
In Windows, pressing `Ctrl + C` in a terminal terminates the currently running command (`SIGINT`). Mac users frequently kill their active servers or compilation scripts by accident when trying to copy.
* **In Windows Terminal, PowerShell, CMD, and Git Bash:**
  * `Cmd + C` safely copies the highlighted text.
  * `Cmd + V` pastes into the terminal prompt.
  * **`Ctrl + C` remains untouched** so you can still stop processes intentionally.

### 2. Spotlight Search (`Cmd + Space`) 🔍
Pressing `Cmd + Space` opens **Flow Launcher** pre-configured with the custom `macOS.flow` theme:
* Instant application search.
* Inline math calculator (`12 * 85 + 400`).
* File searching and web queries.

### 3. One-Click Gaming Mode (`Ctrl + Shift + G`) 🎮
When launching Steam or competitive games:
* Press **`Ctrl + Shift + G`** to immediately suspend all desktop keyboard hooks.
* A notification confirms Gaming Mode is active.
* Press **`Ctrl + Shift + G`** when you finish to resume your macOS shortcuts.

---

## 💾 Automatic Backup & Safe Rollback

Every time you run `install.ps1`, Macify creates a timestamped snapshot of your Windows environment under `backups/`:
* Pre-existing startup shortcuts
* Explorer and Taskbar registry keys
* PowerShell profile backup
* Environment manifest

### Instant Rollback
To restore your computer back to 100% vanilla Windows:

```powershell
cd macify-windows

# Rollback shortcuts & restore registry:
.\scripts\restore.ps1

# To also uninstall Seelen UI and Flow Launcher:
.\scripts\restore.ps1 -UninstallApps
```

Zero leftover system modifications or corrupt registry settings.

---

## 🌐 Portable Setup for Your Other PCs

Because this configuration is self-contained in a single folder, you can deploy it to any new Windows PC or laptop in seconds:

```powershell
git clone https://github.com/brilianpmw/macify-windows.git
cd macify-windows
.\scripts\install.ps1 -WithSeelenUI -WithFlowLauncher
```

---

## 📂 Repository Layout

```text
macify-windows/
├── README.md                          # Main project guide & documentation
├── backups/                           # Automatic snapshots of pre-install states
├── configs/
│   ├── autohotkey/
│   │   └── Macify.ahk                 # Modular AHK v2 macOS keyboard engine
│   └── flow-launcher/                 # Spotlight configuration & macOS theme
├── docs/
│   ├── 01-environment-discovery.md    # Windows 11 & Apple keyboard discovery
│   ├── 02-project-research.md         # In-depth analysis of Kinto, Seelen UI, Windhawk
│   ├── 03-target-experience.md        # Full shortcut mapping specifications
│   ├── 04-architecture-plan.md        # Architecture, risk assessment, and rollback
│   ├── 05-keyboard-reference.md       # Shortcut reference cheat sheet
│   ├── 06-testing-and-verification.md # Verification checklist
│   └── 07-user-tutorial-guide.md      # Illustrated step-by-step tutorial
└── scripts/
    ├── install.ps1                    # Automated installer with pre-backup
    ├── backup.ps1                     # System state snapshot script
    ├── restore.ps1                    # System rollback & recovery script
    ├── uninstall.ps1                  # Uninstaller
    └── toggle-gaming-mode.ps1         # CLI shortcut for gaming mode toggle
```

---

## 📄 License

Open-source under the [MIT License](LICENSE). Built for developers and creators who love both macOS ergonomics and Windows performance.
