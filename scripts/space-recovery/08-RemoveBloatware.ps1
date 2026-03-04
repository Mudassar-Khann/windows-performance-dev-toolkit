#Requires -RunAsAdministrator
<#
.SYNOPSIS    Removes pre-installed Microsoft UWP apps useless on a developer machine.
.SAFETY      Safe — all listed apps can be reinstalled from the Microsoft Store.
.GAIN        500 MB–2 GB + fewer background processes.
#>

Write-Host ""
Write-Host "  [08] Remove Windows Bloatware" -ForegroundColor Cyan
Write-Host "  ─────────────────────────────────────────" -ForegroundColor DarkGray

$bloatware = @(
    "Microsoft.BingWeather",
    "Microsoft.BingNews",
    "Microsoft.GetHelp",
    "Microsoft.Getstarted",
    "Microsoft.MicrosoftSolitaireCollection",
    "Microsoft.People",
    "Microsoft.Wallet",
    "Microsoft.Xbox.TCUI",
    "Microsoft.XboxApp",
    "Microsoft.XboxGameOverlay",
    "Microsoft.XboxGamingOverlay",
    "Microsoft.XboxIdentityProvider",
    "Microsoft.XboxSpeechToTextOverlay",
    "Microsoft.YourPhone",
    "Microsoft.ZuneMusic",
    "Microsoft.ZuneVideo",
    "MicrosoftTeams",
    "Clipchamp.Clipchamp"
)

$removed = 0
$skipped = 0

foreach ($app in $bloatware) {
    $pkg = Get-AppxPackage -Name $app -ErrorAction SilentlyContinue
    if ($pkg) {
        Remove-AppxPackage -Package $pkg.PackageFullName -ErrorAction SilentlyContinue
        Write-Host "  ✔  Removed: $app" -ForegroundColor Yellow
        $removed++
    } else {
        Write-Host "  –  Not installed: $app" -ForegroundColor DarkGray
        $skipped++
    }
}

Write-Host ""
Write-Host "  ✔  Done. Removed: $removed  |  Not found: $skipped" -ForegroundColor Green
