<#
.SYNOPSIS    Lists all programs registered to run at Windows startup.
.SAFETY      Read-Only — no changes made. Use output with script 14 to disable specific apps.
.GAIN        Awareness — identify what's slowing your boot and eating RAM at login.
#>

Write-Host ""
Write-Host "  [18] Startup Programs" -ForegroundColor Cyan
Write-Host "  ─────────────────────────────────────────" -ForegroundColor DarkGray
Write-Host ""

Get-CimInstance Win32_StartupCommand |
    Select-Object Name, Command, Location, User |
    Format-Table -AutoSize

Write-Host ""
Write-Host "  ℹ  Use the Name column value in script 14 to disable a specific app." -ForegroundColor DarkGray
