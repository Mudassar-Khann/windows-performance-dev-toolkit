#Requires -RunAsAdministrator
<#
.SYNOPSIS
    Windows 11 Developer Toolkit - Interactive Menu
.DESCRIPTION
    A collection of PowerShell scripts to optimize performance,
    free disk space, and maintain a Windows 11 developer machine.
.NOTES
    Author:     Madi
    GitHub:     https://github.com/yourusername/win11-dev-toolkit
    Requires:   PowerShell 5.1+ | Run as Administrator
#>

Set-StrictMode -Version Latest
$ErrorActionPreference = "SilentlyContinue"

# ─────────────────────────────────────────────
#  COLORS & HELPERS
# ─────────────────────────────────────────────



function Write-Section($title) {
    Write-Host ""
    Write-Host "  ┌─ $title " -ForegroundColor DarkCyan -NoNewline
    Write-Host ("─" * (60 - $title.Length)) -ForegroundColor DarkGray
}

function Write-MenuItem($number, $label, $gain, $safety) {
    $safetyColor = switch ($safety) {
        "very-safe" { "Green" }
        "safe"      { "Green" }
        "moderate"  { "Yellow" }
        "read-only" { "Cyan" }
        default     { "White" }
    }
    $safetyLabel = switch ($safety) {
        "very-safe" { "[VERY SAFE]" }
        "safe"      { "[SAFE]     " }
        "moderate"  { "[MODERATE] " }
        "read-only" { "[READ-ONLY]" }
        default     { "[UNKNOWN]  " }
    }
    Write-Host "  " -NoNewline
    Write-Host " $number " -ForegroundColor Black -BackgroundColor DarkCyan -NoNewline
    Write-Host " $label" -ForegroundColor White -NoNewline
    $padding = 42 - $label.Length
    if ($padding -gt 0) { Write-Host (" " * $padding) -NoNewline }
    Write-Host "$safetyLabel" -ForegroundColor $safetyColor -NoNewline
    Write-Host "  $gain" -ForegroundColor DarkGray
}

function Confirm-Action($message) {
    Write-Host ""
    Write-Host "  ⚠  $message" -ForegroundColor Yellow
    Write-Host "  Continue? [Y/N]: " -ForegroundColor White -NoNewline
    $key = Read-Host
    return ($key -eq "Y" -or $key -eq "y")
}

function Write-Done($message) {
    Write-Host ""
    Write-Host "  ✔  $message" -ForegroundColor Green
    Write-Host ""
    Write-Host "  Press any key to return to menu..." -ForegroundColor DarkGray
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}

# ─────────────────────────────────────────────
#  MAIN MENU LOOP
# ─────────────────────────────────────────────

do {
    Write-Header

    Write-Section "SPACE RECOVERY"
    Write-MenuItem  1  "Temp File Cleanup"                    "1-10 GB"   "very-safe"
    Write-MenuItem  2  "Delivery Optimization Cache"          "1-5 GB"    "very-safe"
    Write-MenuItem  3  "Windows Disk Cleanup (GUI)"           "3-15 GB"   "very-safe"
    Write-MenuItem  4  "Disable Hibernate (hiberfil.sys)"     "8-16 GB"   "safe"
    Write-MenuItem  5  "Dev Tool Caches (npm/pip/yarn/nuget)" "1-10 GB"   "very-safe"
    Write-MenuItem  6  "Docker Cleanup"                       "5-40 GB"   "safe"
    Write-MenuItem  7  "WSL2 Virtual Disk Compaction"         "5-30 GB"   "safe"
    Write-MenuItem  8  "Remove Windows Bloatware"             "0.5-2 GB"  "safe"
    Write-MenuItem  9  "Clear Event Logs"                     "50MB-2 GB" "very-safe"

    Write-Section "PERFORMANCE"
    Write-MenuItem  10 "Dev Performance Tweaks (Registry)"    "Snappier UI"       "moderate"
    Write-MenuItem  11 "Disable Unnecessary Services"         "Less idle RAM"     "moderate"
    Write-MenuItem  12 "Windows Defender Dev Exclusions"      "20-60% faster build" "moderate"
    Write-MenuItem  13 "Network Stack Optimization"           "Lower latency"     "safe"
    Write-MenuItem  14 "Disable a Startup App"                "Faster boot"       "safe"

    Write-Section "DIAGNOSTICS"
    Write-MenuItem  15 "Scan Largest Folders on C:"           "Awareness"  "read-only"
    Write-MenuItem  16 "Find Files Larger Than 100 MB"        "Awareness"  "read-only"
    Write-MenuItem  17 "Top CPU & RAM Consumers"              "Awareness"  "read-only"
    Write-MenuItem  18 "List All Startup Programs"            "Awareness"  "read-only"
    Write-MenuItem  19 "Check Page File Usage"                "Awareness"  "read-only"

    Write-Section "MAINTENANCE"
    Write-MenuItem  20 "Rebuild Icon & Thumbnail Cache"       "Fixes Explorer"    "very-safe"
    Write-MenuItem  21 "Flush DNS + Store Cache"              "200MB-1GB RAM"     "very-safe"
    Write-MenuItem  22 "Run ALL Space Recovery Scripts"       "Up to 100+ GB"     "safe"

    Write-Host ""
    Write-Host "  ─────────────────────────────────────────────────────────────────────────────────────────────────" -ForegroundColor DarkGray
    Write-Host "  [0] Exit" -ForegroundColor DarkGray
    Write-Host ""
    Write-Host "  Enter number: " -ForegroundColor Cyan -NoNewline
    $choice = Read-Host

    switch ($choice) {
        "1"  { & "$PSScriptRoot\scripts\space-recovery\01-TempFileCleanup.ps1" ;        Write-Done "Temp files cleaned." }
        "2"  { & "$PSScriptRoot\scripts\space-recovery\02-DeliveryOptCache.ps1" ;       Write-Done "Delivery Optimization cache cleared." }
        "3"  { & "$PSScriptRoot\scripts\space-recovery\03-DiskCleanupGUI.ps1" ;         Write-Done "Disk Cleanup launched." }
        "4"  { if (Confirm-Action "This disables hibernate and removes hiberfil.sys. Fast Startup will also be disabled.") {
                   & "$PSScriptRoot\scripts\space-recovery\04-DisableHibernate.ps1"
                   Write-Done "Hibernate disabled. Restart to reclaim space." } }
        "5"  { & "$PSScriptRoot\scripts\space-recovery\05-DevToolCaches.ps1" ;          Write-Done "Dev caches cleared." }
        "6"  { & "$PSScriptRoot\scripts\space-recovery\06-DockerCleanup.ps1" ;          Write-Done "Docker cleanup done." }
        "7"  { if (Confirm-Action "WSL2 will be shut down during compaction.") {
                   & "$PSScriptRoot\scripts\space-recovery\07-WSL2Compact.ps1"
                   Write-Done "WSL2 disk compacted." } }
        "8"  { if (Confirm-Action "This removes pre-installed Microsoft UWP apps. They can be reinstalled from the Store.") {
                   & "$PSScriptRoot\scripts\space-recovery\08-RemoveBloatware.ps1"
                   Write-Done "Bloatware removed." } }
        "9"  { & "$PSScriptRoot\scripts\space-recovery\09-ClearEventLogs.ps1" ;         Write-Done "Event logs cleared." }
        "10" { if (Confirm-Action "Registry changes will be made. All are reversible.") {
                   & "$PSScriptRoot\scripts\performance\10-PerfTweaks.ps1"
                   Write-Done "Performance tweaks applied. Restart recommended." } }
        "11" { if (Confirm-Action "Some background services will be disabled. Review the script before running.") {
                   & "$PSScriptRoot\scripts\performance\11-DisableServices.ps1"
                   Write-Done "Services disabled." } }
        "12" { & "$PSScriptRoot\scripts\performance\12-DefenderExclusions.ps1" ;        Write-Done "Defender exclusions set." }
        "13" { & "$PSScriptRoot\scripts\performance\13-NetworkOptimize.ps1" ;           Write-Done "Network stack optimized. Restart recommended." }
        "14" { & "$PSScriptRoot\scripts\performance\14-DisableStartupApp.ps1" ;         Write-Done "Done." }
        "15" { & "$PSScriptRoot\scripts\diagnostics\15-LargeFolderScan.ps1" ;           Write-Done "Scan complete." }
        "16" { & "$PSScriptRoot\scripts\diagnostics\16-LargeFileScan.ps1" ;             Write-Done "Scan complete." }
        "17" { & "$PSScriptRoot\scripts\diagnostics\17-CPURAMMonitor.ps1" ;             Write-Done "Done." }
        "18" { & "$PSScriptRoot\scripts\diagnostics\18-ListStartupPrograms.ps1" ;       Write-Done "Done." }
        "19" { & "$PSScriptRoot\scripts\diagnostics\19-PageFileCheck.ps1" ;             Write-Done "Done." }
        "20" { & "$PSScriptRoot\scripts\maintenance\20-RebuildIconCache.ps1" ;          Write-Done "Cache rebuilt." }
        "21" { & "$PSScriptRoot\scripts\maintenance\21-FlushDNS.ps1" ;                  Write-Done "DNS flushed." }
        "22" { if (Confirm-Action "This will run all Space Recovery scripts in sequence.") {
                   & "$PSScriptRoot\scripts\space-recovery\01-TempFileCleanup.ps1"
                   & "$PSScriptRoot\scripts\space-recovery\02-DeliveryOptCache.ps1"
                   & "$PSScriptRoot\scripts\space-recovery\05-DevToolCaches.ps1"
                   & "$PSScriptRoot\scripts\space-recovery\06-DockerCleanup.ps1"
                   & "$PSScriptRoot\scripts\space-recovery\09-ClearEventLogs.ps1"
                   Write-Done "All safe space recovery scripts completed." } }
        "0"  { Write-Host ""; Write-Host "  Goodbye." -ForegroundColor DarkGray; Write-Host ""; exit }
        default { Write-Host "  Invalid choice." -ForegroundColor Red; Start-Sleep 1 }
    }

} while ($true)
