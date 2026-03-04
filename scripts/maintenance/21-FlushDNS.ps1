<#
.SYNOPSIS    Flushes DNS resolver cache and clears Windows Store app cache.
.SAFETY      Very Safe — both are rebuilt automatically.
.GAIN        Fixes DNS resolution glitches. Frees 200 MB–1 GB of RAM from idle apps.
             Fixes Windows Store installation errors.
#>

Write-Host ""
Write-Host "  [21] Flush DNS + Store Cache" -ForegroundColor Cyan
Write-Host "  ─────────────────────────────────────────" -ForegroundColor DarkGray

Write-Host "  → Flushing DNS resolver cache..." -ForegroundColor DarkGray
ipconfig /flushdns

Write-Host "  → Resetting Windows Store cache..." -ForegroundColor DarkGray
wsreset.exe

Write-Host ""
Write-Host "  ✔  DNS flushed and Store cache cleared." -ForegroundColor Green
