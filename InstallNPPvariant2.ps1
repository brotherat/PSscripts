## Get the JSON
$webAPIData = Invoke-RestMethod -Uri "https://api.github.com/repos/notepad-plus-plus/notepad-plus-plus/releases/latest"

## The download information is stored in the "assets" section of the data
$assets = $webAPIData.assets

## The pipeline operator is used to filter the assets object to find the release version
$asset = $assets | where-object { $_.name -match "x64" -and $_.name -match ".exe" -and $_.name -notmatch ".exe.sig" }

## Download the latest version
Write-output "Downloading $($asset.name)"
Invoke-WebRequest $asset.browser_download_url -OutFile "$pwd\$($asset.name)"

$outfile = Get-ChildItem $pwd\npp.*.*

# Silently install NotepadPlusPlus then remove the downloaded item
Start-Process -FilePath $outfile -Args "/S" -Verb RunAs -Wait
Remove-Item $outfile
