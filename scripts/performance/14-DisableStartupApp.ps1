#Requires -RunAsAdministrator
<#
.SYNOPSIS    Removes a specific application from Windows startup registry entries.
.SAFETY      Safe — only touches registry Run keys.
.GAIN        Faster boot, less RAM consumed at startup.

HOW TO USE:
  Called from Run-Toolkit.ps1 which prompts for the app name.
  Or run directly: .\14-DisableStartupApp.ps1 -AppName "Discord"
  Get exact names from script 18 (List Startup Programs).
#>

param(
    [Parameter(Mandatory = $true)]
    [string]$AppName
)

Write-Host ""
Write-Host "  [14] Disable Startup App" -ForegroundColor Cyan
Write-Host "  ─────────────────────────────────────────" -ForegroundColor DarkGray
Write-Host "  → Searching for '$AppName' in startup registry locations..." -ForegroundColor DarkGray

$regPaths = @(
    "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run",
    "HKLM:\Software\Microsoft\Windows\CurrentVersion\Run",
    "HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Run"
)

$found = $false
foreach ($path in $regPaths) {
    if (Get-ItemProperty -Path $path -Name $AppName -ErrorAction SilentlyContinue) {
        Remove-ItemProperty -Path $path -Name $AppName -Force -ErrorAction SilentlyContinue
        Write-Host "  ✔  Removed '$AppName' from: $path" -ForegroundColor Yellow
        $found = $true
    }
}

if (-not $found) {
    Write-Host "  –  '$AppName' not found in any startup registry location." -ForegroundColor DarkGray
    Write-Host "  ℹ  Run script 18 to list all startup programs and find the exact name." -ForegroundColor DarkGray
}
