#Requires -RunAsAdministrator
<#
.SYNOPSIS    Tunes the Windows TCP/IP stack for developer workloads.
.SAFETY      Safe — well-documented settings. Restart recommended after.
.GAIN        Lower localhost API call latency, faster file transfers, better throughput.
#>

Write-Host ""
Write-Host "  [13] Network Stack Optimization" -ForegroundColor Cyan
Write-Host "  ─────────────────────────────────────────" -ForegroundColor DarkGray

Write-Host "  → Enabling TCP auto-tuning..." -ForegroundColor DarkGray
netsh int tcp set global autotuninglevel=normal

Write-Host "  → Enabling Receive Side Scaling (multi-core networking)..." -ForegroundColor DarkGray
netsh int tcp set global rss=enabled

Write-Host "  → Enabling TCP Chimney offload..." -ForegroundColor DarkGray
netsh int tcp set global chimney=enabled

Write-Host "  → Disabling ECN (can cause issues with some routers)..." -ForegroundColor DarkGray
netsh int tcp set global ecncapability=disabled

Write-Host "  → Flushing DNS cache..." -ForegroundColor DarkGray
ipconfig /flushdns

Write-Host "  → Resetting Winsock catalog..." -ForegroundColor DarkGray
netsh winsock reset

Write-Host ""
Write-Host "  ✔  Network stack optimized." -ForegroundColor Green
Write-Host "  ℹ  Restart required for Winsock reset to take full effect." -ForegroundColor DarkGray
