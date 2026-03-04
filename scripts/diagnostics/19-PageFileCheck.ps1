<#
.SYNOPSIS    Shows current pagefile configuration and live usage statistics.
.SAFETY      Read-Only — no changes made.
.GAIN        Awareness — identify if pagefile on C: is over-allocated or if moving it would help.
#>

Write-Host ""
Write-Host "  [19] Page File Check" -ForegroundColor Cyan
Write-Host "  ─────────────────────────────────────────" -ForegroundColor DarkGray
Write-Host ""
Write-Host "  Current pagefile USAGE:" -ForegroundColor White

Get-CimInstance -ClassName Win32_PageFileUsage |
    Select-Object Name,
        @{Name="Allocated (MB)"; Expression={$_.AllocatedBaseSize}},
        @{Name="Current Use (MB)"; Expression={$_.CurrentUsage}},
        @{Name="Peak Use (MB)"; Expression={$_.PeakUsage}} |
    Format-Table -AutoSize

Write-Host "  Current pagefile SETTINGS:" -ForegroundColor White

Get-CimInstance -ClassName Win32_PageFileSetting |
    Select-Object Name,
        @{Name="Initial (MB)"; Expression={$_.InitialSize}},
        @{Name="Max (MB)"; Expression={$_.MaximumSize}} |
    Format-Table -AutoSize

Write-Host "  ℹ  If C: pagefile is large and you have a second SSD, consider moving it." -ForegroundColor DarkGray
Write-Host "  ℹ  See docs/pagefile-guide.md for instructions." -ForegroundColor DarkGray
