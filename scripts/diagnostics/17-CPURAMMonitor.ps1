<#
.SYNOPSIS    Shows top 15 processes by CPU and RAM usage right now.
.SAFETY      Read-Only — no changes made.
.GAIN        Awareness — identify silent CPU/RAM hogs at idle.
#>

Write-Host ""
Write-Host "  [17] Top CPU & RAM Consumers" -ForegroundColor Cyan
Write-Host "  ─────────────────────────────────────────" -ForegroundColor DarkGray
Write-Host ""

Get-Process |
    Sort-Object CPU -Descending |
    Select-Object -First 15 Name, Id,
        @{Name="CPU (s)";  Expression={[math]::Round($_.CPU, 1)}},
        @{Name="RAM (MB)"; Expression={[math]::Round($_.WorkingSet64 / 1MB, 1)}} |
    Format-Table -AutoSize
