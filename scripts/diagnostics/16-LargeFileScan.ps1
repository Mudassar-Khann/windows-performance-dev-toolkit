#Requires -RunAsAdministrator
<#
.SYNOPSIS    Scans C: for individual files larger than 100 MB.
.SAFETY      Read-Only — no changes made.
.GAIN        Awareness — find forgotten ISOs, crash dumps, old VM disks, bloated logs.
#>

Write-Host ""
Write-Host "  [16] Large File Scanner (>100 MB)" -ForegroundColor Cyan
Write-Host "  ─────────────────────────────────────────" -ForegroundColor DarkGray
Write-Host "  → Scanning C:\ for files over 100 MB..." -ForegroundColor DarkGray
Write-Host ""

Get-ChildItem -Path "C:\" -Recurse -File -ErrorAction SilentlyContinue |
    Where-Object { $_.Length -gt 100MB } |
    Select-Object FullName,
                  @{Name="Size (MB)"; Expression={[math]::Round($_.Length / 1MB, 1)}} |
    Sort-Object "Size (MB)" -Descending |
    Select-Object -First 30 |
    Format-Table -AutoSize
