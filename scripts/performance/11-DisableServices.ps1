#Requires -RunAsAdministrator
<#
.SYNOPSIS    Disables background services unnecessary on a developer machine.
.SAFETY      Moderate — review each entry. Comment out any service you actually use.
.GAIN        Less idle RAM, faster boot time.

SERVICES DISABLED:
  Fax            - Fax service. Nobody uses this.
  XblAuthManager - Xbox Live authentication.
  XblGameSave    - Xbox cloud game saves.
  XboxNetApiSvc  - Xbox networking API.
  DiagTrack      - Connected User Experiences & Telemetry (Microsoft data pipe).
  SysMain        - Superfetch/Prefetch. Unnecessary and sometimes harmful on SSDs.
  # Spooler      - Print spooler. Uncomment ONLY if you never print.
#>

Write-Host ""
Write-Host "  [11] Disable Unnecessary Services" -ForegroundColor Cyan
Write-Host "  ─────────────────────────────────────────" -ForegroundColor DarkGray

$servicesToDisable = @(
    "Fax",
    "XblAuthManager",
    "XblGameSave",
    "XboxNetApiSvc",
    "DiagTrack",
    "SysMain"
    # "Spooler"   # Uncomment to also disable printing
)

$disabled = 0
foreach ($svc in $servicesToDisable) {
    $s = Get-Service -Name $svc -ErrorAction SilentlyContinue
    if ($s) {
        Stop-Service -Name $svc -Force -ErrorAction SilentlyContinue
        Set-Service -Name $svc -StartupType Disabled
        Write-Host "  ✔  Disabled: $svc" -ForegroundColor Yellow
        $disabled++
    } else {
        Write-Host "  –  Not found (skipped): $svc" -ForegroundColor DarkGray
    }
}

Write-Host ""
Write-Host "  ✔  $disabled service(s) disabled." -ForegroundColor Green
Write-Host "  ℹ  To re-enable any service: Set-Service -Name <name> -StartupType Automatic" -ForegroundColor DarkGray
