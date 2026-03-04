#Requires -RunAsAdministrator
<#
.SYNOPSIS    Opens built-in Windows Disk Cleanup with system file access.
.SAFETY      Very Safe — GUI tool, you choose what to delete.
.GAIN        3–15 GB (Windows Update Cleanup option alone can be 3–15 GB)
#>

Write-Host ""
Write-Host "  [03] Windows Disk Cleanup (GUI)" -ForegroundColor Cyan
Write-Host "  ─────────────────────────────────────────" -ForegroundColor DarkGray
Write-Host "  → Opening selection dialog. Check all boxes you want, then close." -ForegroundColor DarkGray
Write-Host "  ★  Tip: Select 'Windows Update Cleanup' for the biggest gain." -ForegroundColor Yellow

cleanmgr /sageset:65535
cleanmgr /sagerun:65535
