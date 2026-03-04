# Page File Guide

The pagefile (`pagefile.sys`) is Windows virtual memory — it's used when RAM is full.
By default Windows manages it automatically on `C:`, which can consume 4–16 GB.

## Should you move it?

Move it **only if** you have a second SSD (not HDD). Moving pagefile to a second SSD
frees space on C: without performance loss.

**Do NOT move it if:**
- You only have one drive
- Your second drive is an HDD (slower than keeping it on C: SSD)

---

## How to Move Pagefile to D: (Manual Method)

Open PowerShell as Administrator and run:

```powershell
# Step 1: Disable automatic management
$cs = Get-WmiObject -Class Win32_ComputerSystem
$cs.AutomaticManagedPagefile = $false
$cs.Put()

# Step 2: Remove pagefile from C:
$pageFileOnC = Get-WmiObject -Class Win32_PageFileSetting | Where-Object { $_.Name -like "C:*" }
if ($pageFileOnC) { $pageFileOnC.Delete() }

# Step 3: Create pagefile on D:
# Set sizes to 1.5x your RAM (example: 16 GB RAM → 24576 MB)
Set-WmiInstance -Class Win32_PageFileSetting -Arguments @{
    Name        = "D:\pagefile.sys"
    InitialSize = 8192    # adjust to your RAM
    MaximumSize = 16384   # adjust to your RAM
}
```

Restart your PC after running this.

---

## How to Restore Default (Automatic) Management

```powershell
$cs = Get-WmiObject -Class Win32_ComputerSystem
$cs.AutomaticManagedPagefile = $true
$cs.Put()
```

Restart after running.
