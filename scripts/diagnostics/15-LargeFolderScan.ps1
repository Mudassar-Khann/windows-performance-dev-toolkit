#Requires -RunAsAdministrator
<#
.SYNOPSIS    Lists the top 20 largest directories on C: by size.
.SAFETY      Read-Only — no changes made.
.GAIN        Awareness — find where your space is actually going.
#>

Write-Host ""
Write-Host "  [15] Large Folder Scanner" -ForegroundColor Cyan
Write-Host "  ─────────────────────────────────────────" -ForegroundColor DarkGray
Write-Host "  → Scanning C:\ (this may take 1–3 minutes)..." -ForegroundColor DarkGray
Write-Host ""

Get-ChildItem -Path "C:\" -Directory -ErrorAction SilentlyContinue |
    ForEach-Object {
        $size = (Get-ChildItem -Path $_.FullName -Recurse -File -ErrorAction SilentlyContinue |
                 Measure-Object -Property Length -Sum).Sum
        [PSCustomObject]@{
            Folder     = $_.FullName
            "Size (GB)" = [math]::Round($size / 1GB, 2)
        }
    } |
    Sort-Object "Size (GB)" -Descending |
    Select-Object -First 20 |
    Format-Table -AutoSize
