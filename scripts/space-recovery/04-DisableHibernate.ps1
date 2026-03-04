#Requires -RunAsAdministrator
<#
.SYNOPSIS    Disables hibernate and removes hiberfil.sys from C:.
.SAFETY      Safe — do NOT use if you rely on hibernate/sleep on a laptop away from power.
.GAIN        8–16 GB (equal to your installed RAM size)
#>

Write-Host ""
Write-Host "  [04] Disable Hibernate" -ForegroundColor Cyan
Write-Host "  ─────────────────────────────────────────" -ForegroundColor DarkGray

Write-Host "  → Current power states available:" -ForegroundColor DarkGray
powercfg /a

Write-Host ""
Write-Host "  → Disabling hibernate..." -ForegroundColor DarkGray
powercfg /hibernate off

Write-Host "  ✔  Hibernate disabled. hiberfil.sys will be deleted on next restart." -ForegroundColor Green
Write-Host "  ℹ  To re-enable: powercfg /hibernate on" -ForegroundColor DarkGray
