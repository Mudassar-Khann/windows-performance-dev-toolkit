# 🛠️ Win11 Dev Toolkit

![Platform](https://img.shields.io/badge/platform-Windows%2011-blue?logo=windows)
![PowerShell](https://img.shields.io/badge/PowerShell-5.1%2B-blue?logo=powershell)
![License](https://img.shields.io/badge/license-MIT-green)
![Scripts](https://img.shields.io/badge/scripts-21-orange)

A CLI toolkit for Windows 11 developer machines. Cleans disk space, tunes performance, and runs diagnostics — all from a single interactive PowerShell menu. No installers, no dependencies, no frontend.

---

## Why This Exists

Developer machines accumulate gigabytes of waste silently: WSL2 virtual disks that never shrink, Docker layer caches, npm/pip caches from every project ever run, Windows Update leftovers, hiberfil.sys eating RAM-sized chunks of SSD space. Windows Defender scanning `node_modules` on every build adds minutes to compile times.

This toolkit addresses all of that in one place with a clear, safe, interactive menu.

---

## Demo

```
  ██████╗ ███████╗██╗   ██╗    ████████╗ ██████╗  ██████╗ ██╗     ██╗  ██╗██╗████████╗
  ██╔══██╗██╔════╝██║   ██║    ╚══██╔══╝██╔═══██╗██╔═══██╗██║     ██║ ██╔╝██║╚══██╔══╝
  ██║  ██║█████╗  ██║   ██║       ██║   ██║   ██║██║   ██║██║     █████╔╝ ██║   ██║
  ██║  ██║██╔══╝  ╚██╗ ██╔╝       ██║   ██║   ██║██║   ██║██║     ██╔═██╗ ██║   ██║
  ██████╔╝███████╗ ╚████╔╝        ██║   ╚██████╔╝╚██████╔╝███████╗██║  ██╗██║   ██║

  Windows 11 Developer Toolkit  |  Run as Administrator

  ┌─ SPACE RECOVERY ──────────────────────────────────────────────────
   01  Temp File Cleanup                [VERY SAFE]   1-10 GB
   04  Disable Hibernate (hiberfil.sys) [SAFE]        8-16 GB
   05  Dev Tool Caches (npm/pip/yarn)   [VERY SAFE]   1-10 GB
   06  Docker Cleanup                   [SAFE]        5-40 GB

  ✔  Space freed: +6.3 GB  (C: was 18.4 GB free → now 24.7 GB free)
```

---

## Quick Start

```powershell
# 1. Clone the repo
git clone https://github.com/Mudassar-Khann/windows-performance-dev-toolkit.git
cd win11-dev-toolkit

# 2. Allow local scripts to run (one-time)
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser

# 3. Launch (must be Administrator)
.\Run-Toolkit.ps1
```

> ⚠️ **Right-click PowerShell → "Run as Administrator"** before launching.

---

## What's Inside

### Space Recovery

| # | Script | Safety | Expected Gain |
|---|--------|--------|---------------|
| 01 | Temp File Cleanup | ✅ Very Safe | 1–10 GB |
| 02 | Delivery Optimization Cache | ✅ Very Safe | 1–5 GB |
| 03 | Windows Disk Cleanup (GUI) | ✅ Very Safe | 3–15 GB |
| 04 | Disable Hibernate (hiberfil.sys) | ✅ Safe | 8–16 GB |
| 05 | Dev Tool Caches (npm / pip / yarn / pnpm / NuGet) | ✅ Very Safe | 1–10 GB |
| 06 | Docker Cleanup | ✅ Safe | 5–40 GB |
| 07 | WSL2 Virtual Disk Compaction | ✅ Safe | 5–30 GB |
| 08 | Remove Windows Bloatware | ✅ Safe | 0.5–2 GB |
| 09 | Clear Event Logs | ✅ Very Safe | 50 MB–2 GB |

### Performance

| # | Script | Safety | Result |
|---|--------|--------|--------|
| 10 | Dev Performance Tweaks (Registry) | ⚠️ Moderate | Snappier UI, better CPU scheduling |
| 11 | Disable Unnecessary Services | ⚠️ Moderate | Less idle RAM, faster boot |
| 12 | Windows Defender Dev Exclusions | ⚠️ Moderate | 20–60% faster build times |
| 13 | Network Stack Optimization | ✅ Safe | Lower localhost latency |
| 14 | Disable a Startup App | ✅ Safe | Faster login, less RAM at startup |

### Diagnostics

| # | Script | Safety | What It Shows |
|---|--------|--------|---------------|
| 15 | Scan Largest Folders on C: | 🔵 Read-Only | Where your space is going |
| 16 | Find Files Larger Than 100 MB | 🔵 Read-Only | Forgotten ISOs, crash dumps, old VMs |
| 17 | Top CPU & RAM Consumers | 🔵 Read-Only | Silent background hogs |
| 18 | List All Startup Programs | 🔵 Read-Only | What launches at login |
| 19 | Check Page File Usage | 🔵 Read-Only | Virtual memory allocation on C: |

### Maintenance

| # | Script | Safety | Result |
|---|--------|--------|--------|
| 20 | Rebuild Icon & Thumbnail Cache | ✅ Very Safe | Fixes slow/broken File Explorer |
| 21 | Flush DNS + Store Cache | ✅ Very Safe | Fixes network glitches, Store errors |
| 22 | Run ALL Space Recovery Scripts | ✅ Safe | Up to 100+ GB in one pass |

---

## Features

- **Before/after measurement** — shows exactly how many GB each cleanup freed on C:
- **Run log** — every action saved to `toolkit-log.txt` with timestamps
- **Confirmation prompts** — moderate-risk scripts ask before making changes
- **Tool detection** — dev cache scripts skip tools not installed on your machine
- **Standalone scripts** — every script runs independently without the menu

---

## Project Structure

```
win11-dev-toolkit/
├── Run-Toolkit.ps1              ← Interactive menu (start here)
├── toolkit-log.txt              ← Auto-generated run history
├── scripts/
│   ├── space-recovery/          ← Scripts 01–09
│   ├── performance/             ← Scripts 10–14
│   ├── diagnostics/             ← Scripts 15–19
│   └── maintenance/             ← Scripts 20–21
├── docs/
│   └── pagefile-guide.md
├── .gitignore
├── LICENSE
└── README.md
```

---

## Safety Levels

| Badge | Meaning |
|-------|---------|
| ✅ **Very Safe** | Deletes throwaway data Windows regenerates automatically. |
| ✅ **Safe** | Well-tested, fully reversible operations. |
| ⚠️ **Moderate** | Makes registry or service changes. Reversible — read the script before running. |
| 🔵 **Read-Only** | Only reads system information. Makes zero changes. |

---

## Recommended First Run

```
Script 15  →  scan C: to see where space is going
Script 01  →  clean temp files (safest, fastest win)
Script 05  →  clear dev tool caches
Script 04  →  disable hibernate (big space win)
Script 12  →  Defender exclusions (biggest build speed win)
Script 06  →  Docker cleanup (if applicable)
Script 07  →  WSL2 compaction (if applicable)
```

---

## Running Scripts Directly (Without the Menu)

Every script is self-contained:

```powershell
# Run any script directly
.\scripts\space-recovery\06-DockerCleanup.ps1

# Script 14 takes a parameter
.\scripts\performance\14-DisableStartupApp.ps1 -AppName "Discord"
```

---

## Requirements

- Windows 11 (most scripts work on Windows 10 too)
- PowerShell 5.1 or later
- Administrator privileges

---

## Contributing

PRs welcome. To add a script:
1. Place it in the correct category folder with a sequential number prefix
2. Include `.SYNOPSIS`, `.SAFETY`, and `.GAIN` comment blocks at the top
3. Add a row to the README table
4. Add a menu entry in `Run-Toolkit.ps1`

---

## License

MIT — use freely, no warranty.
