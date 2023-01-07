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

if ($prerelease) {
    Write-Host "Current version is a pre-release, nothing to do"
    exit
}

Write-Host "Checking server version to see if we need to build a new version for $version"
$serverFile = choco find -e gopass --version $version | Out-String

if ($serverFile.Contains($version)) {
    Write-Host "Server knows about the current version, nothing to do"
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

choco uninstall -y gopass
choco install -y gopass -s .

if ($? -eq $false) {
    Write-Host "Test install was unsuccesful"
    exit -2
}

$newVersion = gopass -v | Out-String
if ($newVersion.Contains($version)) {
    Write-Host "New version install successful"
    Write-Host "This script is currently in testing, therefore doesn't upload the package automatically"

    # choco push -s https://push.chocolatey.org/
}
