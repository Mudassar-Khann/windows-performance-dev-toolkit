#Requires -RunAsAdministrator
<#
.SYNOPSIS    Compacts the WSL2 virtual disk (ext4.vhdx) to reclaim unused space.
.SAFETY      Safe — WSL is shut down first. No data is deleted, only empty space reclaimed.
.GAIN        5–30 GB depending on how heavily WSL2 has been used.
#>

Write-Host ""
Write-Host "  [07] WSL2 Virtual Disk Compaction" -ForegroundColor Cyan
Write-Host "  ─────────────────────────────────────────" -ForegroundColor DarkGray

Write-Host "  → Shutting down WSL2..." -ForegroundColor DarkGray
wsl --shutdown
Start-Sleep -Seconds 3

# Try to find the VHDX — handles both Ubuntu and Ubuntu-22.04 package names
$vhdxPath = Get-ChildItem "$env:LOCALAPPDATA\Packages" -Recurse -Filter "ext4.vhdx" -ErrorAction SilentlyContinue |
            Select-Object -First 1 -ExpandProperty FullName

if (-not $vhdxPath) {
    Write-Host "  ✘  ext4.vhdx not found. You may not have WSL2 installed, or it's in a non-default location." -ForegroundColor Red
    Write-Host "  ℹ  Search manually: Get-ChildItem C:\Users\$env:USERNAME\AppData\Local\Packages -Recurse -Filter ext4.vhdx" -ForegroundColor DarkGray
    return
}

Write-Host "  ✔  Found VHDX: $vhdxPath" -ForegroundColor Green
Write-Host "  → Running diskpart to compact..." -ForegroundColor DarkGray

$diskpartScript = @"
select vdisk file="$vhdxPath"
attach vdisk readonly
compact vdisk
detach vdisk
exit
"@

$diskpartScript | diskpart

Write-Host "  ✔  WSL2 disk compacted successfully." -ForegroundColor Green
