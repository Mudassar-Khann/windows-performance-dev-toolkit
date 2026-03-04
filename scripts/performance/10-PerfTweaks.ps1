#Requires -RunAsAdministrator
<#
.SYNOPSIS    Applies registry-based performance tweaks for developer workloads.
.SAFETY      Moderate — all changes are reversible via registry or Settings.
.GAIN        Snappier UI, faster CPU context switches, lower GPU load.
#>

Write-Host ""
Write-Host "  [10] Dev Performance Tweaks" -ForegroundColor Cyan
Write-Host "  ─────────────────────────────────────────" -ForegroundColor DarkGray

Write-Host "  → Setting High Performance power plan..." -ForegroundColor DarkGray
powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c

Write-Host "  → Adjusting CPU scheduling to favor foreground apps..." -ForegroundColor DarkGray
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\PriorityControl" `
    -Name "Win32PrioritySeparation" -Value 38

Write-Host "  → Disabling visual animations..." -ForegroundColor DarkGray
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" `
    -Name "VisualFXSetting" -Value 2 -ErrorAction SilentlyContinue

Write-Host "  → Disabling transparency effects..." -ForegroundColor DarkGray
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" `
    -Name "EnableTransparency" -Value 0

Write-Host ""
Write-Host "  ✔  Performance tweaks applied." -ForegroundColor Green
Write-Host "  ℹ  Restart or sign out to see full effect." -ForegroundColor DarkGray
Write-Host "  ℹ  To restore animations: Settings > Accessibility > Visual Effects" -ForegroundColor DarkGray
