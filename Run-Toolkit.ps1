#Requires -RunAsAdministrator
<#
.SYNOPSIS  Win11 Dev Toolkit - interactive menu for space recovery, performance, and diagnostics.
.NOTES
    Author:   Mudassar Khan
    GitHub:   https://github.com/Mudassar-Khann
    Requires: PowerShell 5.1+  |  Run as Administrator
#>

Set-StrictMode -Version Latest
# ErrorActionPreference is intentionally left at default.
# Each script uses -ErrorAction SilentlyContinue only on operations where
# partial failure is expected (e.g. deleting files in use).

# ── helpers ──────────────────────────────────────────────────────────────────

function Write-Header {
    Clear-Host
    Write-Host ""
    Write-Host "  Win11 Dev Toolkit" -ForegroundColor Cyan
    Write-Host "  ─────────────────────────────────────────────────────────" -ForegroundColor DarkGray
    Write-Host "  Space recovery  |  Performance  |  Diagnostics  |  Maintenance" -ForegroundColor DarkGray
    Write-Host "  https://github.com/Mudassar-Khann/windows-performance-dev-toolkit#" -ForegroundColor DarkGray
    Write-Host ""

    $free = Get-FreeDiskSpaceGB
    if ($free) {
        Write-Host "  C: free space: $free GB" -ForegroundColor DarkGray
    }
    Write-Host ""
}

function Write-Section($title) {
    Write-Host ""
    Write-Host "  -- $title" -ForegroundColor Cyan
    Write-Host ""
}

function Write-MenuItem($number, $label, $gain, $safety) {
    $safetyColor = switch ($safety) {
        "very-safe" { "Green"  }
        "safe"      { "Green"  }
        "moderate"  { "Yellow" }
        "read-only" { "Cyan"   }
        default     { "White"  }
    }
    $safetyTag = switch ($safety) {
        "very-safe" { "very-safe" }
        "safe"      { "safe      " }
        "moderate"  { "moderate  " }
        "read-only" { "read-only" }
        default     { "unknown   " }
    }
    $num = $number.ToString().PadLeft(2)
    Write-Host "  $num  " -NoNewline -ForegroundColor DarkGray
    Write-Host "$label" -NoNewline -ForegroundColor White
    $pad = 44 - $label.Length
    if ($pad -gt 0) { Write-Host (" " * $pad) -NoNewline }
    Write-Host "$safetyTag" -NoNewline -ForegroundColor $safetyColor
    Write-Host "  $gain" -ForegroundColor DarkGray
}

function Confirm-Action($message) {
    Write-Host ""
    Write-Host "  ! $message" -ForegroundColor Yellow
    Write-Host "  Continue? [y/N]: " -ForegroundColor White -NoNewline
    $key = Read-Host
    return ($key -eq "y" -or $key -eq "Y")
}

function Write-Done($message) {
    Write-Host ""
    Write-Host "  ok  $message" -ForegroundColor Green
    Write-Log $message
    Write-Host ""
    Write-Host "  Press any key to go back..." -ForegroundColor DarkGray
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}

function Get-FreeDiskSpaceGB {
    $d = Get-PSDrive -Name C -ErrorAction SilentlyContinue
    if ($d) { return [math]::Round($d.Free / 1GB, 2) }
    return $null
}

function Write-SpaceGain($beforeGB) {
    $afterGB = Get-FreeDiskSpaceGB
    if ($null -eq $beforeGB -or $null -eq $afterGB) { return }
    $gained = [math]::Round($afterGB - $beforeGB, 2)
    if ($gained -gt 0) {
        Write-Host "  freed: +$gained GB  ($beforeGB GB -> $afterGB GB free on C:)" -ForegroundColor Green
    } else {
        Write-Host "  no measurable change (already clean, or files were in use)" -ForegroundColor DarkGray
    }
}

$script:LogFile = "$PSScriptRoot\toolkit-log.txt"
function Write-Log($message) {
    $ts = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    "$ts  $message" | Out-File -FilePath $script:LogFile -Append -ErrorAction SilentlyContinue
}

# ── menu loop ─────────────────────────────────────────────────────────────────

do {
    Write-Header

    Write-Section "SPACE RECOVERY"
    Write-MenuItem  1  "Temp File Cleanup"                    "1-10 GB"    "very-safe"
    Write-MenuItem  2  "Delivery Optimization Cache"          "1-5 GB"     "very-safe"
    Write-MenuItem  3  "Windows Disk Cleanup (GUI)"           "3-15 GB"    "very-safe"
    Write-MenuItem  4  "Disable Hibernate  (hiberfil.sys)"    "8-16 GB"    "safe"
    Write-MenuItem  5  "Dev Tool Caches (npm/pip/yarn/nuget)" "1-10 GB"    "very-safe"
    Write-MenuItem  6  "Docker Cleanup"                       "5-40 GB"    "safe"
    Write-MenuItem  7  "WSL2 Virtual Disk Compaction"         "5-30 GB"    "safe"
    Write-MenuItem  8  "Remove Windows Bloatware"             "0.5-2 GB"   "safe"
    Write-MenuItem  9  "Clear Event Logs"                     "50MB-2 GB"  "very-safe"

    Write-Section "PERFORMANCE"
    Write-MenuItem  10 "Dev Performance Tweaks (Registry)"    "Snappier UI"          "moderate"
    Write-MenuItem  11 "Disable Unnecessary Services"         "Less idle RAM"        "moderate"
    Write-MenuItem  12 "Windows Defender Dev Exclusions"      "20-60% faster builds" "moderate"
    Write-MenuItem  13 "Network Stack Optimization"           "Lower latency"        "safe"
    Write-MenuItem  14 "Disable a Startup App"                "Faster boot"          "safe"

    Write-Section "DIAGNOSTICS"
    Write-MenuItem  15 "Scan Largest Folders on C:"           "find space hogs"      "read-only"
    Write-MenuItem  16 "Find Files Larger Than 100 MB"        "find forgotten files" "read-only"
    Write-MenuItem  17 "Top CPU and RAM Consumers"            "find idle hogs"       "read-only"
    Write-MenuItem  18 "List All Startup Programs"            "map boot items"       "read-only"
    Write-MenuItem  19 "Check Page File Usage"                "pagefile on C:"       "read-only"

    Write-Section "MAINTENANCE"
    Write-MenuItem  20 "Rebuild Icon and Thumbnail Cache"     "fix Explorer"         "very-safe"
    Write-MenuItem  21 "Flush DNS and Store Cache"            "fix network glitches" "very-safe"
    Write-MenuItem  22 "Run ALL Space Recovery Scripts"       "up to 100+ GB"        "safe"

    Write-Host ""
    Write-Host "  ─────────────────────────────────────────────────────────" -ForegroundColor DarkGray
    Write-Host "   0  Exit" -ForegroundColor DarkGray
    Write-Host ""
    Write-Host "  > " -NoNewline -ForegroundColor Cyan
    $choice = Read-Host

    switch ($choice) {
        "1"  { $b = Get-FreeDiskSpaceGB
               & "$PSScriptRoot\scripts\space-recovery\01-TempFileCleanup.ps1"
               Write-SpaceGain $b; Write-Done "Temp files cleaned." }

        "2"  { $b = Get-FreeDiskSpaceGB
               & "$PSScriptRoot\scripts\space-recovery\02-DeliveryOptCache.ps1"
               Write-SpaceGain $b; Write-Done "Delivery Optimization cache cleared." }

        "3"  { & "$PSScriptRoot\scripts\space-recovery\03-DiskCleanupGUI.ps1"
               Write-Done "Disk Cleanup launched." }

        "4"  { if (Confirm-Action "Disables hibernate. hiberfil.sys will be deleted on next restart. Fast Startup also disabled.") {
                   & "$PSScriptRoot\scripts\space-recovery\04-DisableHibernate.ps1"
                   Write-Done "Hibernate disabled. Restart to reclaim space." } }

        "5"  { $b = Get-FreeDiskSpaceGB
               & "$PSScriptRoot\scripts\space-recovery\05-DevToolCaches.ps1"
               Write-SpaceGain $b; Write-Done "Dev caches cleared." }

        "6"  { $b = Get-FreeDiskSpaceGB
               & "$PSScriptRoot\scripts\space-recovery\06-DockerCleanup.ps1"
               Write-SpaceGain $b; Write-Done "Docker cleanup done." }

        "7"  { if (Confirm-Action "WSL2 will be shut down during compaction.") {
                   $b = Get-FreeDiskSpaceGB
                   & "$PSScriptRoot\scripts\space-recovery\07-WSL2Compact.ps1"
                   Write-SpaceGain $b; Write-Done "WSL2 disk compacted." } }

        "8"  { if (Confirm-Action "Removes pre-installed UWP apps. All can be reinstalled from the Store.") {
                   $b = Get-FreeDiskSpaceGB
                   & "$PSScriptRoot\scripts\space-recovery\08-RemoveBloatware.ps1"
                   Write-SpaceGain $b; Write-Done "Bloatware removed." } }

        "9"  { $b = Get-FreeDiskSpaceGB
               & "$PSScriptRoot\scripts\space-recovery\09-ClearEventLogs.ps1"
               Write-SpaceGain $b; Write-Done "Event logs cleared." }

        "10" { if (Confirm-Action "Makes registry changes (power plan, CPU scheduling, animations). All reversible.") {
                   & "$PSScriptRoot\scripts\performance\10-PerfTweaks.ps1"
                   Write-Done "Performance tweaks applied. Restart recommended." } }

        "11" { if (Confirm-Action "Disables Xbox, Fax, Superfetch, and telemetry services. Review script first.") {
                   & "$PSScriptRoot\scripts\performance\11-DisableServices.ps1"
                   Write-Done "Services disabled." } }

        "12" { & "$PSScriptRoot\scripts\performance\12-DefenderExclusions.ps1"
               Write-Done "Defender exclusions set." }

        "13" { & "$PSScriptRoot\scripts\performance\13-NetworkOptimize.ps1"
               Write-Done "Network stack optimized. Restart recommended." }

        "14" { Write-Host ""
               Write-Host "  Tip: run option 18 first to see exact app names." -ForegroundColor DarkGray
               Write-Host "  App name to remove from startup: " -NoNewline -ForegroundColor Cyan
               $appInput = Read-Host
               if ($appInput.Trim()) {
                   & "$PSScriptRoot\scripts\performance\14-DisableStartupApp.ps1" -AppName $appInput.Trim()
                   Write-Done "Done."
               } else {
                   Write-Host "  Cancelled." -ForegroundColor DarkGray
               } }

        "15" { & "$PSScriptRoot\scripts\diagnostics\15-LargeFolderScan.ps1";    Write-Done "Scan complete." }
        "16" { & "$PSScriptRoot\scripts\diagnostics\16-LargeFileScan.ps1";      Write-Done "Scan complete." }
        "17" { & "$PSScriptRoot\scripts\diagnostics\17-CPURAMMonitor.ps1";      Write-Done "Done." }
        "18" { & "$PSScriptRoot\scripts\diagnostics\18-ListStartupPrograms.ps1"; Write-Done "Done." }
        "19" { & "$PSScriptRoot\scripts\diagnostics\19-PageFileCheck.ps1";      Write-Done "Done." }
        "20" { & "$PSScriptRoot\scripts\maintenance\20-RebuildIconCache.ps1";   Write-Done "Cache rebuilt." }
        "21" { & "$PSScriptRoot\scripts\maintenance\21-FlushDNS.ps1";           Write-Done "DNS flushed." }

        "22" { if (Confirm-Action "Runs all safe space recovery scripts in sequence (1,2,5,6,9).") {
                   $b = Get-FreeDiskSpaceGB
                   & "$PSScriptRoot\scripts\space-recovery\01-TempFileCleanup.ps1"
                   & "$PSScriptRoot\scripts\space-recovery\02-DeliveryOptCache.ps1"
                   & "$PSScriptRoot\scripts\space-recovery\05-DevToolCaches.ps1"
                   & "$PSScriptRoot\scripts\space-recovery\06-DockerCleanup.ps1"
                   & "$PSScriptRoot\scripts\space-recovery\09-ClearEventLogs.ps1"
                   Write-SpaceGain $b
                   Write-Done "All space recovery scripts completed." } }

        "0"  { Write-Host ""; exit }

        default { Write-Host "  invalid choice" -ForegroundColor Red; Start-Sleep 1 }
    }

} while ($true)
