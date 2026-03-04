#Requires -RunAsAdministrator
<#
.SYNOPSIS    Clears Windows Update Delivery Optimization peer-sharing cache.
.SAFETY      Very Safe — only needed if you share updates across a LAN.
.GAIN        1–5 GB
#>

Write-Host ""
Write-Host "  [02] Delivery Optimization Cache" -ForegroundColor Cyan
Write-Host "  ─────────────────────────────────────────" -ForegroundColor DarkGray

Write-Host "  → Flushing via cmdlet..." -ForegroundColor DarkGray
Delete-DeliveryOptimizationCache -Force -ErrorAction SilentlyContinue

Write-Host "  → Removing cache folder contents..." -ForegroundColor DarkGray
Remove-Item -Path "C:\Windows\ServiceProfiles\NetworkService\AppData\Local\Microsoft\Windows\DeliveryOptimization\Cache\*" `
    -Recurse -Force -ErrorAction SilentlyContinue

Write-Host "  ✔  Delivery Optimization cache cleared." -ForegroundColor Green
