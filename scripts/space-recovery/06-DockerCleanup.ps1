#Requires -RunAsAdministrator
<#
.SYNOPSIS    Removes stopped containers, dangling images, unused volumes, and build cache.
.SAFETY      Safe — running containers are NOT touched. Only unused/stopped resources.
.GAIN        5–40 GB (Docker silently accumulates this over months)
#>

Write-Host ""
Write-Host "  [06] Docker Cleanup" -ForegroundColor Cyan
Write-Host "  ─────────────────────────────────────────" -ForegroundColor DarkGray

if (-not (Get-Command docker -ErrorAction SilentlyContinue)) {
    Write-Host "  –  Docker not found. Skipping." -ForegroundColor DarkGray
    return
}

Write-Host "  → Removing stopped containers..." -ForegroundColor DarkGray
docker container prune -f

Write-Host "  → Removing dangling images..." -ForegroundColor DarkGray
docker image prune -f

Write-Host "  → Removing unused volumes..." -ForegroundColor DarkGray
docker volume prune -f

Write-Host "  → Removing unused networks..." -ForegroundColor DarkGray
docker network prune -f

Write-Host "  → Clearing build cache..." -ForegroundColor DarkGray
docker builder prune -f

Write-Host ""
Write-Host "  ✔  Docker cleanup complete." -ForegroundColor Green
Write-Host "  ℹ  To also remove ALL unused images (re-pull required): docker image prune -a -f" -ForegroundColor DarkGray
Write-Host "  ℹ  Nuclear option (removes everything): docker system prune -a --volumes -f" -ForegroundColor DarkGray
