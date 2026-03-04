#Requires -RunAsAdministrator
<#
.SYNOPSIS    Removes a specific application from Windows startup registry entries.
.SAFETY      Safe — edit $appName before running. Only touches registry Run keys.
.GAIN        Faster boot, less RAM consumed at startup.

HOW TO USE:
  1. Run script 18 (List Startup Programs) first to get the exact app name.
  2. Set $appName below to match exactly.
  3. Run this script.
#>

Write-Host ""
Write-Host "  [14] Disable Startup App" -ForegroundColor Cyan
Write-Host "  ─────────────────────────────────────────" -ForegroundColor DarkGray

# ── EDIT THIS: Set to exact name from script 18 output ──
$appName = "Discord"

$regPaths = @(
    "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run",
    "HKLM:\Software\Microsoft\Windows\CurrentVersion\Run",
    "HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Run"
)

$found = $false
foreach ($path in $regPaths) {
    if (Get-ItemProperty -Path $path -Name $appName -ErrorAction SilentlyContinue) {
        Remove-ItemProperty -Path $path -Name $appName -Force
        Write-Host "  ✔  Removed '$appName' from: $path" -ForegroundColor Yellow
        $found = $true
    }
}

if (-not $found) {
    Write-Host "  –  '$appName' not found in any startup registry location." -ForegroundColor DarkGray
    Write-Host "  ℹ  Run script 18 to list startup programs and find the exact name." -ForegroundColor DarkGray
}
