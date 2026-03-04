#Requires -RunAsAdministrator
<#
.SYNOPSIS    Deletes temporary files from user, system, Windows Update cache, and Prefetch.
.SAFETY      Very Safe — Windows regenerates all of these automatically.
.GAIN        1–10 GB depending on last cleanup date.
#>

Write-Host ""
Write-Host "  [01] Temp File Cleanup" -ForegroundColor Cyan
Write-Host "  ─────────────────────────────────────────" -ForegroundColor DarkGray

Write-Host "  → Cleaning user temp folder..." -ForegroundColor DarkGray
Remove-Item -Path "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue

Write-Host "  → Cleaning system temp folder..." -ForegroundColor DarkGray
Remove-Item -Path "C:\Windows\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue

Write-Host "  → Clearing Windows Update download cache..." -ForegroundColor DarkGray
Stop-Service -Name wuauserv -Force -ErrorAction SilentlyContinue
Remove-Item -Path "C:\Windows\SoftwareDistribution\Download\*" -Recurse -Force -ErrorAction SilentlyContinue
Start-Service -Name wuauserv -ErrorAction SilentlyContinue

Write-Host "  → Emptying Recycle Bin..." -ForegroundColor DarkGray
Clear-RecycleBin -Force -ErrorAction SilentlyContinue

Write-Host "  → Clearing Prefetch..." -ForegroundColor DarkGray
Remove-Item -Path "C:\Windows\Prefetch\*" -Force -ErrorAction SilentlyContinue

Write-Host "  ✔  Temp files cleared." -ForegroundColor Green
