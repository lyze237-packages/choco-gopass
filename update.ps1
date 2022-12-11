function Invoke-Replace {
    param ($file, $from, $to)

    (Get-Content -Encoding UTF8 $file).Replace($from,$to) | Set-Content -Encoding UTF8 $file
}

function Get-Asset {
    param ($response)

    $assets = $response.Content | ConvertFrom-Json | Select-Object -expand "assets"

    foreach ($asset in $assets) 
    {
        if ($asset.name.EndsWith("windows-amd64.zip")) {
            return $asset;
        }
    }
}

$response = Invoke-WebRequest -Uri https://api.github.com/repos/gopasspw/gopass/releases/latest -UseBasicParsing
$json = $response.Content | ConvertFrom-Json 

$version = $json.tag_name.Replace("v", "")
$prerelease = $json.prerelease
$asset = Get-Asset $response

Write-Host "Checking if we need to build a new version for $version"
Write-Host "Building current version to see what version we're on"
$packedFile = choco pack | Out-String

if ($prerelease) {
    Write-Host "Current version is a pre-release, nothing to do"
    exit
}

if ($packedFile.Contains($version)) {
    Write-Host "We're on the same version, nothing to do"
    exit
}

Write-Host "Checking md5 sum of version $version"
Invoke-WebRequest -UseBasicParsing -uri $asset.browser_download_url -OutFile "gopass.zip"
$hash = Get-FileHash -Algorithm MD5 "gopass.zip"
Write-Host "Checksum is $hash"

Write-Host "Replacing contents of nuspec and chocolateyinstall.ps1 "
Invoke-Replace gopass.nuspec '$VERSION' $version
Invoke-Replace tools/chocolateyinstall.ps1 '$URL' $asset.browser_download_url
Invoke-Replace tools/chocolateyinstall.ps1 '$CHECKSUM' $hash.hash

Write-Host "Building new version"
Remove-Item *.nupkg
choco pack

if ($? -eq $false) {
    Write-Host "Pack was unsuccesful"
    exit -1
}

choco push -s https://push.chocolatey.org/