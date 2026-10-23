# 🎓 Macify Windows — Complete User Tutorial & Guide

Welcome to **Macify Windows**! If you're a Mac user transitioning to Windows or regularly switching between a MacBook and a Windows PC, this tutorial will guide you through everyday workflows so your hands feel right at home.

---

## 🎯 1. Hand & Thumb Positioning

### On an Apple Magic Keyboard connected via Bluetooth
* Your thumb naturally rests on the physical **Command (⌘)** key.
* Windows recognizes this key as `LWin`.
* **Macify** translates this so pressing **Command + C** or **Command + V** triggers Windows Copy/Paste seamlessly without moving your thumb to `Ctrl`.

### On a Standard Windows / PC Keyboard
* The keys on the left are: `[Ctrl] [Win] [Alt] [Spacebar]`
* Your thumb naturally rests on **Alt**.
* **Macify** has dual-layer mapping: both `Win` and `Alt` trigger Mac shortcuts (`Alt + C`, `Alt + V`, `Alt + Space`, `Alt + Shift + 4`).

---

## 📸 2. Mastering Screenshots

Taking screenshots on Windows often requires awkward two-handed finger yoga (`Win + Shift + S` or hunting for the `PrintScreen` key). Macify brings the beloved macOS muscle memory:

```
┌────────────────────────────────────────────────────────┐
│  Cmd + Shift + 4  ──►  Draw box to snip region         │
│  Cmd + Shift + 3  ──►  Instant full-screen to clipboard│
│  Cmd + Shift + 5  ──►  Snip & screen recording bar     │
└────────────────────────────────────────────────────────┘
```

1. **Quick Snippet for Chat / Slack / Discord:**
   * Press `Cmd + Shift + 4`.
   * The screen dims and a crosshair cursor appears.
   * Drag your box around the area you want.
   * Release! It is instantly copied to your clipboard.
   * Press `Cmd + V` in your chat app to paste it immediately.

---

## 📝 3. Text Navigation & Code Editing

Windows text navigation normally relies on `Ctrl` for words and `Home`/`End` for lines. Macify aligns Windows text behavior with macOS:

| What you want to do | Press on Keyboard | What it does |
| :--- | :--- | :--- |
| **Jump cursor word-by-word** | `Option + ◄` / `Option + ►` | Jumps over words quickly |
| **Delete entire preceding word**| `Option + Backspace` | Deletes word instead of single letter |
| **Jump to line beginning** | `Cmd + ◄` | Moves to column 0 (`Home`) |
| **Jump to line end** | `Cmd + ►` | Moves to line end (`End`) |
| **Highlight to start of line** | `Cmd + Shift + ◄` | Selects from cursor to line start |
| **Highlight to end of line** | `Cmd + Shift + ►` | Selects from cursor to line end |
| **Jump to top/bottom of file** | `Cmd + ▲` / `Cmd + ▼` | Document start / end |

---

## 🔍 4. Spotlight Search (Flow Launcher)

In macOS, `Cmd + Space` is your universal command center for opening apps, calculating math, or searching files.

1. Press **`Cmd + Space`**.
2. A sleek, blurred, rounded search palette appears in the center of your screen.
3. Type:
   * Any app name (e.g. `code`, `terminal`, `chrome`, `steam`).
   * A math calculation (e.g. `45 * 12 + 100`).
   * A web query (e.g. `gh react` or `wiki quantum`).
4. Press `Enter` to open or `Esc` to dismiss.

---

## 🖥️ 5. Developer & Terminal Workflow

One of the most painful traps for Mac developers on Windows:
> In Windows Command Prompt, pressing `Ctrl + C` to copy text accidentally kills your running dev server (`SIGINT`)!

### How Macify solves this:
* Inside **Windows Terminal**, **PowerShell**, **Command Prompt**, and **Git Bash**:
  * **`Cmd + C`** copies the highlighted text.
  * **`Cmd + V`** pastes from your clipboard.
  * **`Ctrl + C`** remains completely untouched as standard `SIGINT` (halts running scripts).
  * You will never accidentally stop your server while trying to copy an error message again!

---

## 🎮 6. Gaming Mode (One-Click Pause)

Windows PC gaming uses `Alt`, `Shift`, and the Windows key heavily. You don't want desktop shortcut remapping interfering with your keybinds in *Counter-Strike*, *Cyberpunk*, or *Valorant*.

* **Shortcut:** Press **`Ctrl + Shift + G`** at any time.
* A notification balloon appears: `"Macify: Gaming Mode Enabled (Shortcuts Paused)"`.
* When you finish playing, press **`Ctrl + Shift + G`** again: `"Macify: macOS Shortcuts Active"`.

---

## 💾 7. Automatic Backup & Safe Rollback

Every time you run `install.ps1`, an automatic snapshot of your startup items and registry configurations is created in the `backups/` directory.

* **To see available backups:** Look in `macify-windows/backups/`.
* **To rollback to your pre-Macify state:**
  ```powershell
  cd macify-windows
  .\scripts\restore.ps1
  ```
* **To also uninstall Seelen UI and Flow Launcher during rollback:**
  ```powershell
  .\scripts\restore.ps1 -UninstallApps
  ```
