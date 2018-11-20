$ErrorActionPreference = 'Stop';

$name          = 'gopass'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'https://github.com/gopasspw/gopass/releases/download/v1.8.3/gopass-1.8.3-windows-386.zip' # download url, HTTPS preferred
$url64         = 'https://github.com/gopasspw/gopass/releases/download/v1.8.3/gopass-1.8.3-windows-amd64.zip' # 64bit URL here (HTTPS preferred) or remove - if installer contains both (very rare), use $url
$checksum      = '13de1f1c8c2382f9f3324b5b9539be9ef46a1951f4364f9585f583a0839ae62d'
$checksum64    = '53738a9002b2b734db0405f8cc0169fd941b2eebed5944439bc135e3d167c551'
$checksumType  = 'sha256'

Install-ChocolateyZipPackage $name $url $toolsDir $url64 -checksum $checksum -checksumType $checksumType -checksum64 $checksum64 -checksumType64 $checksumType64
