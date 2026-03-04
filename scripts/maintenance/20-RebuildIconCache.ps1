#Requires -RunAsAdministrator
<#
.SYNOPSIS    Deletes corrupted icon and thumbnail cache databases. Windows rebuilds automatically.
.SAFETY      Very Safe — worst case: icons look blank for ~30 seconds after Explorer restarts.
.GAIN        Fixes slow/broken File Explorer. Frees 100–500 MB.
#>

Write-Host ""
Write-Host "  [20] Rebuild Icon & Thumbnail Cache" -ForegroundColor Cyan
Write-Host "  ─────────────────────────────────────────" -ForegroundColor DarkGray

Write-Host "  → Stopping Explorer..." -ForegroundColor DarkGray
Stop-Process -Name explorer -Force -ErrorAction SilentlyContinue
Start-Sleep -Seconds 2

Write-Host "  → Deleting thumbnail cache..." -ForegroundColor DarkGray
Remove-Item -Path "$env:LOCALAPPDATA\Microsoft\Windows\Explorer\thumbcache_*.db" `
    -Force -ErrorAction SilentlyContinue

Write-Host "  → Deleting icon cache..." -ForegroundColor DarkGray
Remove-Item -Path "$env:LOCALAPPDATA\Microsoft\Windows\Explorer\iconcache_*.db" `
    -Force -ErrorAction SilentlyContinue

Write-Host "  → Restarting Explorer..." -ForegroundColor DarkGray
Start-Process explorer

Write-Host ""
Write-Host "  ✔  Cache rebuilt. Icons may flicker briefly — that is normal." -ForegroundColor Green
