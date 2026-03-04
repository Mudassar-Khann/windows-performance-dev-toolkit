#Requires -RunAsAdministrator
<#
.SYNOPSIS    Adds Windows Defender exclusions for common dev folders and processes.
.SAFETY      Moderate — only exclude folders YOU own and trust. Never exclude Downloads.
.GAIN        20–60% faster build times on large projects (node_modules, .git scanning eliminated).
#>

Write-Host ""
Write-Host "  [12] Windows Defender Dev Exclusions" -ForegroundColor Cyan
Write-Host "  ─────────────────────────────────────────" -ForegroundColor DarkGray

# ── Edit these paths to match your actual dev folders ──
$devPaths = @(
    "C:\Users\$env:USERNAME\Projects",
    "C:\Users\$env:USERNAME\source",
    "C:\dev",
    "C:\tools"
)

foreach ($path in $devPaths) {
    if (Test-Path $path) {
        Add-MpPreference -ExclusionPath $path
        Write-Host "  ✔  Excluded path: $path" -ForegroundColor Yellow
    } else {
        Write-Host "  –  Path doesn't exist (skipped): $path" -ForegroundColor DarkGray
    }
}

# ── Dev processes excluded from real-time scanning ──
$devProcesses = @(
    "node.exe",
    "python.exe",
    "python3.exe",
    "cargo.exe",
    "go.exe",
    "dotnet.exe",
    "git.exe"
)

Write-Host ""
foreach ($proc in $devProcesses) {
    Add-MpPreference -ExclusionProcess $proc
    Write-Host "  ✔  Excluded process: $proc" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "  ✔  Defender exclusions set." -ForegroundColor Green
Write-Host "  ℹ  To review exclusions: Get-MpPreference | Select ExclusionPath, ExclusionProcess" -ForegroundColor DarkGray
