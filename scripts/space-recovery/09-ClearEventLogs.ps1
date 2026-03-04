#Requires -RunAsAdministrator
<#
.SYNOPSIS    Clears all Windows Event Logs.
.SAFETY      Very Safe — logs are diagnostic only. Clearing has zero functional impact.
.GAIN        50 MB–2 GB on active developer machines.
#>

Write-Host ""
Write-Host "  [09] Clear Event Logs" -ForegroundColor Cyan
Write-Host "  ─────────────────────────────────────────" -ForegroundColor DarkGray

$logs = Get-WinEvent -ListLog * -ErrorAction SilentlyContinue |
        Where-Object { $_.IsEnabled -and $_.RecordCount -gt 0 }

$cleared = 0
foreach ($log in $logs) {
    try {
        [System.Diagnostics.Eventing.Reader.EventLogSession]::GlobalSession.ClearLog($log.LogName)
        Write-Host "  –  Cleared: $($log.LogName)" -ForegroundColor DarkGray
        $cleared++
    } catch { }
}

Write-Host ""
Write-Host "  ✔  Cleared $cleared event logs." -ForegroundColor Green
