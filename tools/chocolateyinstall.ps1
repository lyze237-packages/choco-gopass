$ErrorActionPreference = 'Stop';

$name          = 'gopass'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'https://github.com/gopasspw/gopass/releases/download/v1.8.2/gopass-1.8.2-windows-386.zip' # download url, HTTPS preferred
$url64         = 'https://github.com/gopasspw/gopass/releases/download/v1.8.2/gopass-1.8.2-windows-amd64.zip' # 64bit URL here (HTTPS preferred) or remove - if installer contains both (very rare), use $url
$checksum      = 'aa90844b9bdaabcd9ff9d3b02f1a8911d9d3265bf1f764efa4761c749d8d90bb'
$checksum64    = 'b71369502eb3fd07a14333a99ad38121f4e47c990759de525206be486b7fa262'
$checksumType  = 'sha256'

Install-ChocolateyZipPackage $name $url $toolsDir $url64 -checksum $checksum -checksumType $checksumType -checksum64 $checksum64 -checksumType64 $checksumType64
