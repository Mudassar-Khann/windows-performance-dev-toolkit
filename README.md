# 🛠️ Win11 Dev Toolkit

A collection of PowerShell scripts to optimize performance, free disk space, and maintain a Windows 11 developer machine — all from an interactive CLI menu.

> **No frontend. No installers. Just PowerShell.**

---

## ⚡ Quick Start

```powershell
# 1. Clone the repo
git clone https://github.com/Mudassar-Khann/windows-performance-dev-toolkit.git
cd win11-dev-toolkit

# 2. Allow scripts to run (one-time setup)
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser

# 3. Run the toolkit (as Administrator)
.\Run-Toolkit.ps1
```

> ⚠️ **Must be run as Administrator.** Right-click PowerShell → "Run as Administrator"

---

## 📋 What's Inside

### 🗃️ Space Recovery
| # | Script | Safety | Expected Gain |
|---|--------|--------|---------------|
| 01 | Temp File Cleanup | ✅ Very Safe | 1–10 GB |
| 02 | Delivery Optimization Cache | ✅ Very Safe | 1–5 GB |
| 03 | Windows Disk Cleanup (GUI) | ✅ Very Safe | 3–15 GB |
| 04 | Disable Hibernate (hiberfil.sys) | ✅ Safe | 8–16 GB |
| 05 | Dev Tool Caches (npm/pip/yarn/pnpm/NuGet) | ✅ Very Safe | 1–10 GB |
| 06 | Docker Cleanup | ✅ Safe | 5–40 GB |
| 07 | WSL2 Virtual Disk Compaction | ✅ Safe | 5–30 GB |
| 08 | Remove Windows Bloatware | ✅ Safe | 0.5–2 GB |
| 09 | Clear Event Logs | ✅ Very Safe | 50 MB–2 GB |

### ⚡ Performance
| # | Script | Safety | Result |
|---|--------|--------|--------|
| 10 | Dev Performance Tweaks (Registry) | ⚠️ Moderate | Snappier UI |
| 11 | Disable Unnecessary Services | ⚠️ Moderate | Less idle RAM |
| 12 | Windows Defender Dev Exclusions | ⚠️ Moderate | 20–60% faster builds |
| 13 | Network Stack Optimization | ✅ Safe | Lower latency |
| 14 | Disable a Startup App | ✅ Safe | Faster boot |

### 🔍 Diagnostics
| # | Script | Safety | Result |
|---|--------|--------|--------|
| 15 | Scan Largest Folders on C: | 🔵 Read-Only | Find space hogs |
| 16 | Find Files Larger Than 100 MB | 🔵 Read-Only | Find forgotten ISOs/dumps |
| 17 | Top CPU & RAM Consumers | 🔵 Read-Only | Identify background hogs |
| 18 | List All Startup Programs | 🔵 Read-Only | Map what runs at boot |
| 19 | Check Page File Usage | 🔵 Read-Only | Pagefile awareness |

### 🔧 Maintenance
| # | Script | Safety | Result |
|---|--------|--------|--------|
| 20 | Rebuild Icon & Thumbnail Cache | ✅ Very Safe | Fix slow Explorer |
| 21 | Flush DNS + Store Cache | ✅ Very Safe | Fix network/store glitches |
| 22 | Run ALL Space Recovery Scripts | ✅ Safe | Up to 100+ GB recovered |

---

## 🗂️ Project Structure

```
win11-dev-toolkit/
├── Run-Toolkit.ps1                    ← Main interactive menu
├── scripts/
│   ├── space-recovery/
│   │   ├── 01-TempFileCleanup.ps1
│   │   ├── 02-DeliveryOptCache.ps1
│   │   ├── 03-DiskCleanupGUI.ps1
│   │   ├── 04-DisableHibernate.ps1
│   │   ├── 05-DevToolCaches.ps1
│   │   ├── 06-DockerCleanup.ps1
│   │   ├── 07-WSL2Compact.ps1
│   │   ├── 08-RemoveBloatware.ps1
│   │   └── 09-ClearEventLogs.ps1
│   ├── performance/
│   │   ├── 10-PerfTweaks.ps1
│   │   ├── 11-DisableServices.ps1
│   │   ├── 12-DefenderExclusions.ps1
│   │   ├── 13-NetworkOptimize.ps1
│   │   └── 14-DisableStartupApp.ps1
│   ├── diagnostics/
│   │   ├── 15-LargeFolderScan.ps1
│   │   ├── 16-LargeFileScan.ps1
│   │   ├── 17-CPURAMMonitor.ps1
│   │   ├── 18-ListStartupPrograms.ps1
│   │   └── 19-PageFileCheck.ps1
│   └── maintenance/
│       ├── 20-RebuildIconCache.ps1
│       └── 21-FlushDNS.ps1
├── docs/
│   └── pagefile-guide.md
├── .gitignore
├── LICENSE
└── README.md
```

---

## 🔒 Safety Levels Explained

| Level | Meaning |
|-------|---------|
| ✅ **Very Safe** | Deletes throwaway data. Windows regenerates it. Zero risk. |
| ✅ **Safe** | Well-tested operations. Fully reversible. |
| ⚠️ **Moderate** | Makes registry or service changes. Reversible, but read the script first. |
| 🔵 **Read-Only** | Only reads system info. Makes zero changes. |

---

## 💡 Recommended Run Order (First Time)

1. **Script 15** — scan to see where your space is going
2. **Script 01** — clean temp files (safest, fastest win)
3. **Script 05** — clear dev tool caches
4. **Script 04** — disable hibernate (big space recovery)
5. **Script 03** — GUI cleanup (catch anything else)
6. **Script 12** — Defender exclusions (biggest speed win for devs)
7. **Script 06** — Docker cleanup (if applicable)
8. **Script 07** — WSL2 compaction (if applicable)

---

## ⚙️ Requirements

- Windows 11 (most scripts also work on Windows 10)
- PowerShell 5.1 or later
- Administrator privileges

---

## 🤝 Contributing

Pull requests welcome. If you have a script that helped your dev setup, open a PR with:
- The script file in the correct category folder
- A `.SYNOPSIS`, `.SAFETY`, and `.GAIN` comment block at the top
- An entry in the README table

---

## 📄 License

MIT — use freely, modify freely, no warranty.
