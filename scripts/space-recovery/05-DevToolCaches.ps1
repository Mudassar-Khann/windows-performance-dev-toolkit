#Requires -RunAsAdministrator
<#
.SYNOPSIS    Clears npm, pip, yarn, pnpm, and NuGet package manager caches.
.SAFETY      Very Safe — all caches are rebuilt automatically on next install.
.GAIN        1–10 GB depending on development activity.
#>

Write-Host ""
Write-Host "  [05] Dev Tool Caches" -ForegroundColor Cyan
Write-Host "  ─────────────────────────────────────────" -ForegroundColor DarkGray

if (Get-Command npm -ErrorAction SilentlyContinue) {
    Write-Host "  → Clearing npm cache..." -ForegroundColor DarkGray
    npm cache clean --force
    Write-Host "  ✔  npm done" -ForegroundColor Green
} else { Write-Host "  –  npm not found" -ForegroundColor DarkGray }

if (Get-Command pip -ErrorAction SilentlyContinue) {
    Write-Host "  → Clearing pip cache..." -ForegroundColor DarkGray
    pip cache purge
    Write-Host "  ✔  pip done" -ForegroundColor Green
} else { Write-Host "  –  pip not found" -ForegroundColor DarkGray }

if (Get-Command yarn -ErrorAction SilentlyContinue) {
    Write-Host "  → Clearing yarn cache..." -ForegroundColor DarkGray
    yarn cache clean
    Write-Host "  ✔  yarn done" -ForegroundColor Green
} else { Write-Host "  –  yarn not found" -ForegroundColor DarkGray }

if (Get-Command pnpm -ErrorAction SilentlyContinue) {
    Write-Host "  → Pruning pnpm store..." -ForegroundColor DarkGray
    pnpm store prune
    Write-Host "  ✔  pnpm done" -ForegroundColor Green
} else { Write-Host "  –  pnpm not found" -ForegroundColor DarkGray }

if (Get-Command dotnet -ErrorAction SilentlyContinue) {
    Write-Host "  → Clearing dotnet NuGet cache..." -ForegroundColor DarkGray
    dotnet nuget locals all --clear
    Write-Host "  ✔  dotnet NuGet done" -ForegroundColor Green
} else { Write-Host "  –  dotnet not found" -ForegroundColor DarkGray }

Write-Host "  ✔  All detected dev caches cleared." -ForegroundColor Green
